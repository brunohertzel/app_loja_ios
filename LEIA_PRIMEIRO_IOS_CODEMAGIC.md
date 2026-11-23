# Carnes Merces iOS - Codemagic SEM certificado Apple

**Versao 1.6.40 (build 198)** | Bundle ID `br.com.softsistemas.carnesmerces`

## O que esta versao corrige

O workflow Ad Hoc anterior falhava com:
`No matching profiles found for bundle identifier ... and distribution type ad_hoc`.

Isto ocorre porque a assinatura Ad Hoc exige Apple Developer Program, certificado
Apple Distribution e provisioning profile Ad Hoc. Para testes locais em seu iPhone,
estes requisitos foram REMOVIDOS do processo de build no Codemagic.

O Codemagic compila `Runner.app` em release sem assinatura usando
`flutter build ios --release --no-codesign` e cria `Carnes_Merces_1.6.40_198_UNSIGNED.ipa`.

**ATENCAO: este IPA nao e instalavel diretamente.** Precisa ser assinado no Windows
ou Mac com um Apple ID gratuito usando Sideloadly; entao podera ser instalado no
iPhone conectado. O fluxo de sideload com conta gratuita costuma exigir renovacao
a cada 7 dias, e pode ter limitacoes de apps, recursos e dispositivos.

## Aplicar no repositorio que ja esta no GitHub

1. Extraia `codemagic.yaml` deste patch na raiz local de
   `C:\app_flutter\carnes_merces_ios_codemagic`, SUBSTITUINDO o antigo.
2. No Git Bash:

```bash
cd /c/app_flutter/carnes_merces_ios_codemagic
git add codemagic.yaml
git commit -m "iOS: gerar IPA sem certificado Apple pelo Codemagic"
git push origin main
```

3. No Codemagic, abra `brunohertzel/app_loja_ios`, selecione o workflow
   `carnes-merces-ios-unsigned` e execute o build.
4. Em Artifacts, baixe o arquivo terminado em `_UNSIGNED.ipa`.
5. No Windows, conecte seu iPhone por cabo USB, desbloqueie-o e confie no computador.
6. Abra o Sideloadly (`https://sideloadly.io/`), selecione o IPA e use seu Apple ID gratuito.
   A ferramenta assina o IPA para o iPhone selecionado e o instala.
7. No iPhone, se solicitado, habilite o Modo de Desenvolvedor e confie no perfil
   associado ao seu Apple ID. Confirme que o app abre e acessa a API da loja.

## Observacoes

- **Nao** configure certificados, API keys Apple, `ios_signing` ou `xcode-project use-profiles`.
- Nao use o workflow antigo `carnes-merces-ios-adhoc`.
- O ZIP completo e uma copia atualizada do mesmo codigo Flutter REV5, alterando apenas
  `codemagic.yaml`, instrucoes e comentario do script de preparacao iOS.
- O pacote **nao contem um IPA ja compilado**, pois a compilacao ocorre no macOS do Codemagic.
- Instalar IPA sem assinatura diretamente pelo Safari, Arquivos ou no iPhone sem
  reassinatura nao funciona.
- Alguns recursos que exigem capabilities/entitlements da Apple podem nao estar
  disponiveis com assinatura gratuita; o teste do fluxo principal deve ser validado
  no aparelho.
- Para distribuicao estavel a clientes sera necessario outro metodo de assinatura.

Fontes:
- Codemagic: https://docs.codemagic.io/yaml-quick-start/first-signed-build/
- Apple Personal Team: https://developer.apple.com/help/account/basics/about-your-developer-account/
- Sideloadly: https://sideloadly.io/
