# App 1.6.33+191 / Mobile 1.14.4

Instale primeiro a atualização da loja ou gere/aplique o novo Mobile pelo Soft Licenças. A loja deve manter o motor de localidades Web v2.0.3 e os ajustes do checkout v2.0.7 que já foram aplicados; não substituímos esses arquivos. Configure no Admin > Mobile > Android/iOS a versão/build do release (sugestão 1.6.33 / 191). O build continua lendo API, branding, identidade, versão e build do servidor; não grava dados da loja no código.

Android no PowerShell:
`.\COMPILAR_ANDROID.cmd https://domlevi.com.br/api/mobile/v1`

No iOS, codemagic.yaml possui dois workflows:
- `ios-sem-assinatura`: release sem assinatura enquanto aguarda a Apple. Gera Runner-release-sem-assinatura.zip para verificar compilação. Não instala em iPhone nem publica no TestFlight.
- `ios-production`: IPA de produção, exige certificado/perfil App Store do Bundle ID configurado.

No Mac para simulador: `bash tooling/prepare_ios.sh https://domlevi.com.br/api/mobile/v1`, `open -a Simulator`, `flutter run --dart-define=SOFT_API_BASE_URL=https://domlevi.com.br/api/mobile/v1` e selecione o simulador. Para IPA: `bash tooling/build_ipa.sh https://domlevi.com.br/api/mobile/v1` com assinatura disponível.

Conta > Meus Endereços e checkout: consultar CEP, adicionar e editar endereços. CEP normal mantém bairro do endereço e não vincula uma localidade fixa. CEP regional terminado em 000: se o modo do canal for localidade e a cidade tiver localidades ativas, a seleção Bairro / Balneário / Distrito é obrigatória e a lista não mostra frete. A lista vem do servidor e respeita cidade, ativo e canal B2C/B2B. Nomes de localidades são exibidos como cadastrados, sem tradução automática.

Cadastro é independente da entrega: fora da área pode salvar, mas não usar para entrega. O checkout consulta elegibilidade; novo endereço fora da área não é selecionado automaticamente. Endereço escolhido não é substituído silenciosamente por outro. Retirada segue habilitação da loja. Frete calculado e revalidado na API ao preparar, trocar endereço, aplicar cupom e concluir pedido, sempre com o endereço salvo e valores atuais do banco. Alterar valor/localidade no corpo da consulta não muda o endereço selecionado. Não faz comprovação geográfica antifraude da localidade declarada; segue o motor atual do site. Outros modos delegam ao motor de frete da loja; quando necessário, usam o helper de endereço preciso já instalado.

No formulário, falha de CEP permite informar endereço manualmente e consultar localidades; falha das regras impede salvar até nova consulta. A API também exige a lista quando aplicável, mesmo para cliente antigo. Sem DDL ou importação de bairros em requisições.

Preserva idiomas PT/EN/ES, biometria, contatos, consentimento de notificações, pedidos anteriores com endereço histórico, LGPD/SAC e pesáveis. Notificações automáticas de pedidos continuam dependendo da integração de envio já descrita na versão anterior. Assinatura Android de produção local preservada: nunca inclua key.properties/keystore/senhas no envio. Patches são para 1.6.32+190; outras bases use completo preservando assinatura.

Pacotes são projetos fonte para compilar; não contêm APK/IPA pré-compilados.
