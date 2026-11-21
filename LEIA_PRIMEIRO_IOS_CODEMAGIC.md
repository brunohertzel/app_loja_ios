# Carnes Mercês — iOS Ad Hoc / Codemagic

Base: Soft Ecommerce Mobile Android REV5 (mesmo Flutter/Dart) — **1.6.40+198**.

- Nome nativo: Carnes Mercês
- Bundle ID: `br.com.softsistemas.carnesmerces`
- API: `https://loja.carnesmerces.com.br/api/mobile/v1`
- Idiomas do aplicativo: Português (Brasil), Inglês, Espanhol
- Distribuição: **Ad Hoc**, somente aparelhos iOS registrados na conta Apple Developer.
- **Esta entrega contém o código-fonte e a configuração Codemagic; não contém IPA assinado.** O IPA será gerado no runner macOS do Codemagic.

## Como compilar sem Mac local

1. Abra esta pasta após descompactar. O **conteúdo** desta pasta (`pubspec.yaml`, `lib/`, `assets/`, `tooling/`, `codemagic.yaml`) deve estar na **raiz de um repositório Git** privado (GitHub/GitLab/Bitbucket) conectado ao Codemagic. Não envie o `.zip` inteiro como um único arquivo para o repositório.
2. Tenha Apple Developer Program ativo e registre o **UDID do iPhone** de teste em Apple Developer (Devices). O profile **Ad Hoc** deve incluir esse UDID.
3. Crie/registe o App ID exato `br.com.softsistemas.carnesmerces` na Apple Developer. Use um certificado Apple Distribution e um provisioning profile **Ad Hoc** vinculados a esse App ID e ao iPhone.
4. No Codemagic: Team settings > Code signing identities, importe o certificado (.p12 com chave privada) e o profile `.mobileprovision`, ou conecte sua API Apple Developer para obtê-los, e confira se correspondem ao Bundle ID acima.
5. No Codemagic, conecte o repositório, selecione **codemagic.yaml** e workflow `carnes-merces-ios-adhoc`, execute **Start new build**. Os scripts criam o projeto nativo `ios/` com a ferramenta oficial Flutter e aplicam permissões, identidade e ícones antes da assinatura.
6. Após build bem-sucedido, baixe `build/ios/ipa/*.ipa` dos Artifacts. Distribua pelo método Ad Hoc de sua preferência; o iPhone destinatário deve estar presente no profile assinado. O app não fica publicado na App Store.
7. Na API/Soft Licenças, o módulo Mobile deve **licenciar/habilitar iOS**; caso contrário, a própria verificação do bootstrap bloqueará a inicialização.

## Como funciona o código

- Código da vitrine, favoritos, cache, layouts, social e GPS igual ao Android REV5; API recebe a plataforma `IOS` automaticamente.
- Android original foi mantido no repositório para preservar a origem. Codemagic compila **somente iOS**.
- `tooling/prepare_ios.py` configura o bundle, nome, iOS mínimo 15, permissões nativas e ícone de testes no projeto gerado automaticamente via `flutter create`.
- `--dart-define=SOFT_API_BASE_URL=...` aponta para a API da Carnes Mercês. O código também contém essa URL como fallback.
- **Nenhum certificado, senha ou chave privada** está incluído neste pacote. Assinatura só no Codemagic.
- O app solicita GPS somente quando a pessoa toca para preencher endereço; o número continua editável.
- As imagens/produtos são consumidos da API do Ecommerce em HTTPS.

## Atenção / limitações

- Ícone nativo **temporário 'CM'** para testes. O splash e branding da vitrine continuam vindo da API; antes de publicação, substitua `tooling/ios_branding/AppIcon.appiconset` pelos arquivos do ícone oficial.
- **Apple Pay não está implementado** no checkout Dart herdado do Android; a forma APPLE_PAY permanece desativada pelo próprio código para não oferecer um pagamento não funcional. PIX, cartão suportado pelo backend e pagamento na entrega continuam conforme as regras do servidor.
- **Login Google no iOS** exige configuração de cliente OAuth iOS / URL scheme no Xcode e integração com a API; o pacote não inventa credenciais. Login padrão por CPF/e-mail e senha permanece disponível.
- **Permissões/notificações push do iOS** exigem implementação Apple/APNs específica; a integração de notificações da base atual usa MethodChannel Android. Isso não impede o fluxo principal da loja.
- O cache persiste fotos; a experiência de fundo (background) não é execução arbitrária de tarefas iOS.
- Requer internet para instalar pacotes CocoaPods e Flutter pelo Codemagic.
- Não há Xcode disponível neste ambiente de geração. A compilação e assinatura **não foram executadas aqui**; valide os logs do Codemagic antes de entregar aos clientes.

## Caso apareça problema na assinatura

- `No profiles for ... were found`: conferir Bundle ID exato, perfil Ad Hoc e certificados no Codemagic.
- `Provisioning profile doesn't include ...`: adicionar UDID ao profile e refazer/importar o profile.
- `Code signing failed`: confirmar Apple Distribution com chave privada e associação ao profile.
- `ITMS-...`: TestFlight/App Store requer um workflow de assinatura diferente (app_store).

Arquivos principais: `codemagic.yaml`, `tooling/prepare_ios.py`, `pubspec.yaml`, `lib/core/config/generated_app_config.dart`.
