import java.io.*;
import java.nio.channels.*;
import java.nio.file.*;
import java.nio.file.attribute.PosixFilePermissions;
import java.security.*;
import java.util.*;
import java.util.stream.Stream;

// Executado pelo mesmo JDK do Gradle. Nao requer keytool no PATH ou PowerShell.
class PrepareAndroidSigning {
    static void privateFile(Path path) throws IOException {
        try { Files.setPosixFilePermissions(path, PosixFilePermissions.fromString("rw-------")); }
        catch (UnsupportedOperationException ignored) { /* Windows: pasta do usuario. */ }
    }

    static Properties load(Path path) throws IOException {
        Properties p = new Properties();
        try (InputStream in = Files.newInputStream(path)) { p.load(in); }
        return p;
    }

    static void validate(Properties p, Path android) throws Exception {
        for (String key : List.of("storeFile", "storePassword", "keyPassword", "keyAlias")) {
            if (p.getProperty(key) == null || p.getProperty(key).isBlank())
                throw new IOException("key.properties incompleto: falta " + key + ". A chave existente foi preservada.");
        }
        Path key = Path.of(p.getProperty("storeFile"));
        if (!key.isAbsolute()) key = android.resolve(key);
        if (p.getProperty("keyAlias").equalsIgnoreCase("androiddebugkey") ||
                key.getFileName().toString().equalsIgnoreCase("debug.keystore"))
            throw new IOException("Release exige chave propria de producao. A configuracao debug foi preservada, mas nao sera usada.");
        if (!Files.isRegularFile(key))
            throw new IOException("Keystore configurado nao encontrado: " + key + ". Restaure sua chave; ela nao sera recriada.");
        try {
            KeyStore store = KeyStore.getInstance(key.toFile(), p.getProperty("storePassword").toCharArray());
            Key entry = store.getKey(p.getProperty("keyAlias"), p.getProperty("keyPassword").toCharArray());
            if (!(entry instanceof PrivateKey)) throw new GeneralSecurityException("Alias sem chave privada");
        } catch (GeneralSecurityException | IOException ex) {
            throw new IOException("Nao foi possivel abrir a chave existente. Confira senhas e alias no key.properties. Nenhuma chave foi substituida.");
        }
    }

    static void store(Properties p, Path path) throws IOException {
        try (OutputStream out = Files.newOutputStream(path, StandardOpenOption.CREATE_NEW)) {
            p.store(out, "AM Soft - assinatura privada. Nao compartilhar ou publicar.");
        }
        privateFile(path);
    }

    static boolean isKey(Path path) {
        String n = path.getFileName().toString().toLowerCase(Locale.ROOT);
        return n.endsWith(".jks") || n.endsWith(".keystore");
    }

    static void run(String[] args) throws Exception {
        if (args.length < 2 || args.length > 3) throw new IOException("Uso: java PrepareAndroidSigning.java PROJETO PACKAGE_ID [PASTA_PRIVADA]");
        Path root = Path.of(args[0]).toAbsolutePath().normalize();
        String pkg = args[1];
        if (!pkg.matches("[A-Za-z][A-Za-z0-9_]*(\\.[A-Za-z][A-Za-z0-9_]*)+")) throw new IOException("Package ID invalido.");
        Path android = root.resolve("android");
        if (!Files.isRegularFile(root.resolve("pubspec.yaml")) || !Files.isDirectory(android)) throw new IOException("Pasta do projeto invalida.");
        Path projectProps = android.resolve("key.properties");
        if (Files.exists(projectProps)) {
            validate(load(projectProps), android);
            System.out.println("Assinatura de producao existente preservada.");
            return;
        }
        String local = System.getenv("LOCALAPPDATA");
        Path cache = args.length == 3 ? Path.of(args[2]).toAbsolutePath().normalize() :
            (local != null && !local.isBlank() ? Path.of(local).resolve("AMSoft/AndroidSigning") :
                Path.of(System.getProperty("user.home")).resolve(".soft-mobile/signing")).resolve(pkg);
        Files.createDirectories(cache);
        try { Files.setPosixFilePermissions(cache, PosixFilePermissions.fromString("rwx------")); }
        catch (UnsupportedOperationException ignored) { }
        Path props = cache.resolve("key.properties");
        Path key = cache.resolve("upload-keystore.jks");
        try (FileChannel channel = FileChannel.open(cache.resolve(".signing.lock"), StandardOpenOption.CREATE, StandardOpenOption.WRITE);
             FileLock lock = channel.lock()) {
            // Outra compilacao pode ter concluido enquanto esperavamos o lock.
            if (Files.exists(projectProps)) { validate(load(projectProps), android); return; }
            if (Files.exists(props)) {
                validate(load(props), android);
                if (!Files.isRegularFile(key)) throw new IOException("Backup incompleto. Restaure o keystore da pasta: " + cache);
            } else {
                if (Files.exists(key)) throw new IOException("A chave ja existe sem configuracao. Restaure key.properties em " + cache + "; ela nao sera substituida.");
                List<Path> candidates = new ArrayList<>();
                try (Stream<Path> paths = Files.list(root)) { paths.filter(Files::isRegularFile).filter(PrepareAndroidSigning::isKey).forEach(candidates::add); }
                try (Stream<Path> paths = Files.walk(android, 3)) { paths.filter(Files::isRegularFile).filter(PrepareAndroidSigning::isKey).forEach(candidates::add); }
                if (!candidates.isEmpty()) throw new IOException("Foi encontrada uma chave no projeto: " + candidates.get(0) + ". Configure android/key.properties para reutiliza-la.");
                boolean windows = System.getProperty("os.name").toLowerCase(Locale.ROOT).contains("windows");
                Path keytool = Path.of(System.getProperty("java.home"), "bin", windows ? "keytool.exe" : "keytool");
                if (!Files.isRegularFile(keytool)) throw new IOException("keytool ausente no JDK do Gradle: " + keytool);
                byte[] random = new byte[32]; new SecureRandom().nextBytes(random);
                String password = Base64.getUrlEncoder().withoutPadding().encodeToString(random);
                Path pendingKey = cache.resolve("upload-keystore.pending-" + UUID.randomUUID() + ".jks");
                Path pendingProps = cache.resolve("key.properties.pending-" + UUID.randomUUID());
                try {
                    ProcessBuilder command = new ProcessBuilder(keytool.toString(), "-genkeypair", "-noprompt", "-keystore", pendingKey.toString(),
                        "-storetype", "JKS", "-keyalg", "RSA", "-keysize", "2048", "-validity", "10000", "-alias", "upload",
                        "-dname", "CN=Soft Ecommerce Android, OU=Mobile, O=AM Soft, C=BR",
                        "-storepass:env", "SOFT_SIGNING_STORE_PASSWORD", "-keypass:env", "SOFT_SIGNING_KEY_PASSWORD");
                    command.environment().put("SOFT_SIGNING_STORE_PASSWORD", password);
                    command.environment().put("SOFT_SIGNING_KEY_PASSWORD", password);
                    command.redirectErrorStream(true);
                    Process process = command.start();
                    String output = new String(process.getInputStream().readAllBytes(), java.nio.charset.StandardCharsets.UTF_8);
                    if (process.waitFor() != 0) throw new IOException("Falha ao criar a assinatura: " + output);
                    privateFile(pendingKey);
                    Properties p = new Properties();
                    p.setProperty("storeFile", pendingKey.toString().replace('\\', '/'));
                    p.setProperty("storePassword", password); p.setProperty("keyPassword", password); p.setProperty("keyAlias", "upload");
                    validate(p, android);
                    p.setProperty("storeFile", key.toString().replace('\\', '/'));
                    store(p, pendingProps);
                    Files.move(pendingKey, key); // Nunca substituir chave existente.
                    Files.move(pendingProps, props);
                    System.out.println("Chave propria de producao criada neste computador.");
                } finally { Files.deleteIfExists(pendingKey); Files.deleteIfExists(pendingProps); }
            }
            validate(load(props), android);
            Path pendingProject = Files.createTempFile(android, "key.properties-", ".tmp");
            try {
                Files.copy(props, pendingProject, StandardCopyOption.REPLACE_EXISTING);
                privateFile(pendingProject);
                Files.move(pendingProject, projectProps);
            } finally { Files.deleteIfExists(pendingProject); }
            System.out.println("Assinatura pronta. Guarde uma copia privada de toda a pasta: " + cache);
        }
    }

    public static void main(String[] args) {
        try { run(args); }
        catch (Exception ex) { System.err.println("AM Soft: " + ex.getMessage()); System.exit(1); }
    }
}
