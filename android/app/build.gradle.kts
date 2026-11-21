import java.util.Properties
import java.io.File
import groovy.json.JsonSlurper
import org.gradle.api.tasks.Exec

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val softConfigFile = file("../../tooling/mobile_app_config.json")
val softConfig: Map<*, *> = if (softConfigFile.exists()) {
    @Suppress("UNCHECKED_CAST")
    val jsonText = softConfigFile.readText(Charsets.UTF_8).removePrefix("\uFEFF").trimStart()
    (JsonSlurper().parseText(jsonText) as? Map<*, *>) ?: emptyMap<Any, Any>()
} else emptyMap<Any, Any>()
fun softText(key: String, fallback: String): String = softConfig[key]?.toString()?.trim()?.takeIf { it.isNotEmpty() } ?: fallback
val softPackageId = softText("android_package_id", "br.com.softsistemas.soft_ecommerce_mobile")
val softAppName = softText("app_name", "Soft Ecommerce")

val releaseKeys = Properties()
val releaseKeyFile = rootProject.file("key.properties")
val productionRequested = gradle.startParameter.taskNames.any { it.contains("release", ignoreCase = true) }
if (productionRequested) {
    val signingHelper = file("../../tooling/PrepareAndroidSigning.java")
    val isWindows = System.getProperty("os.name").lowercase().contains("windows")
    val javaExecutable = File(System.getProperty("java.home"), "bin/" + if (isWindows) "java.exe" else "java")
    val signingExit = ProcessBuilder(
        javaExecutable.absolutePath, signingHelper.absolutePath,
        rootProject.projectDir.parentFile.absolutePath, softPackageId
    ).directory(rootProject.projectDir.parentFile).inheritIO().start().waitFor()
    if (signingExit != 0) throw GradleException("Falha preparando a assinatura de producao. Confira a mensagem AM Soft acima.")
}
if (releaseKeyFile.exists()) releaseKeyFile.inputStream().use { releaseKeys.load(it) }

android {
    namespace = softPackageId
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions { jvmTarget = JavaVersion.VERSION_17.toString() }

    defaultConfig {
        applicationId = softPackageId
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        manifestPlaceholders["softAppName"] = softAppName
    }
    signingConfigs {
        create("release") {
            if (releaseKeyFile.exists()) {
                keyAlias = releaseKeys.getProperty("keyAlias")
                keyPassword = releaseKeys.getProperty("keyPassword")
                storeFile = rootProject.file(releaseKeys.getProperty("storeFile") ?: "")
                storePassword = releaseKeys.getProperty("storePassword")
            }
        }
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isDebuggable = false
        }
    }
}

dependencies { implementation("androidx.appcompat:appcompat:1.7.0") }

val applySoftMobileLocalConfig by tasks.registering(Exec::class) {
    group = "soft mobile"
    description = "Aplica o cache de branding/release sincronizado da API do cliente"
    val script = file("../../tooling/apply_build_config.ps1")
    val isWindows = System.getProperty("os.name").lowercase().contains("windows")
    if (isWindows) {
        commandLine("powershell.exe", "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", script.absolutePath, "-ConfigFile", softConfigFile.absolutePath)
    } else {
        commandLine("pwsh", "-NoProfile", "-File", script.absolutePath, "-ConfigFile", softConfigFile.absolutePath)
    }
    inputs.file(softConfigFile)
    inputs.file(script)
}

tasks.configureEach {
    if (name == "preBuild" || name.startsWith("compileFlutterBuild") || name.startsWith("compileReleaseKotlin") || name.startsWith("compileDebugKotlin")) {
        dependsOn(applySoftMobileLocalConfig)
    }
}

flutter { source = "../.." }
