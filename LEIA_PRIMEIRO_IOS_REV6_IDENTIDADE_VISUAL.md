# Carnes Mercês — iOS REV6 (1.6.40 build 199)

## O que foi corrigido
- Tema Flutter utiliza `bootstrap.app.primary_color` e `secondary_color` retornados pela API do Módulo Mobile (em vez dos defaults azul/cinza).
- Login, Home e splash Flutter usam logo/splash devolvidos por `bootstrap.php`, com fallback para imagens embutidas no IPA.
- **Antes de cada build**, o Codemagic executa `tooling/sync_ios_branding.py`:
  1. Consulta **uma vez** `/api/mobile/v1/bootstrap.php` com `X-Soft-Platform: IOS`.
  2. Baixa as imagens **públicas** `logo_url`, `icon_ios_url`, `splash_url` cadastradas no Mobile.
  3. Gera o snapshot de cores/URLs e copia imagens ao pacote Flutter.
- `tooling/prepare_ios.py` converte o ícone iOS em todos os tamanhos do `AppIcon.appiconset` e incorpora o splash na `LaunchImage.imageset`; o fundo da tela de lançamento usa a cor principal.
- Mantidos iOS >= 15.5, configuração sem assinatura, GPS, idiomas PT/EN/ES, comércio e licença.

**Atenção:** sem comunicação com a API/imagens na compilação, o workflow para com erro informativo. É intencional para evitar entregar novamente ícones genéricos. O ZIP de fontes possui placeholders de dois pixels que **serão substituídos** automaticamente durante o build. O IPA resultante deve incluir a marca verdadeira.

## Atualizar o GitHub sem trocar de pasta
Extraia o ZIP de correção rápida **dentro de** `C:\app_flutter\carnes_merces_ios_codemagic`, substituindo os arquivos.

No Git Bash:

```bash
cd /c/app_flutter/carnes_merces_ios_codemagic
git add codemagic.yaml pubspec.yaml lib/app.dart lib/core/config/generated_app_config.dart lib/features/auth/login_page.dart lib/features/store/store_shell.dart lib/widgets/brand_logo.dart tooling/prepare_ios.py tooling/sync_ios_branding.py assets/brand/logo.png assets/brand/splash.png test/rev6_ios_branding_test.dart LEIA_PRIMEIRO_IOS_REV6_IDENTIDADE_VISUAL.md
git commit -m "iOS: identidade visual real do Mobile, logo cores icone e splash (build 199)"
git push origin main
```

No Codemagic escolha **Carnes Merces - iOS sem certificado** e faça um build novo de `main`.
O artefato será `Carnes_Merces_1.6.40_199_UNSIGNED.ipa`. Ele precisa ser assinado pelo aplicativo de sideload que você já utilizou.

Para conferir o sucesso no log procure:

```text
Branding sincronizado: Carnes Mercês #4F121A / #AE9456
Branding nativo iOS aplicado: icone oficial, LaunchScreen e fundo #4F121A
```

O ícone do iPhone e o LaunchScreen são **nativos** e mudam com um **novo IPA**; as cores e o logo exibidos dentro do app são carregados do bootstrap a cada inicialização.

## Validação
Foi verificada a sintaxe Python e executado um teste local do gerador de ícones e splash com arquivos fictícios, validando os tamanhos, o Podfile e o LaunchScreen. Não foi possível executar Flutter/Xcode neste ambiente; a compilação precisa ser validada pelo Codemagic. As imagens reais são recuperadas pelo **próprio Codemagic** no build, usando a API pública da loja. Não foi acessado o Admin.
