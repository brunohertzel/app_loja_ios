# Soft Ecommerce — Android 1.6.35+193 (base Mobile API 1.14.5)

**Tipo:** projeto fonte Flutter/Android para compilação. **Não é APK pronto.**
**Origem:** projeto real Android 1.6.34+192 preservado e atualizado, não WebView.
**Escopo:** Android primeiro; o projeto iOS será tratado separadamente.

## O que mudou

1. Página inicial com atalhos nativos para Ofertas, Setores, Buscar, Pedidos, Carrinho e, **quando o servidor o habilita**, Clube de Descontos.
2. Departamentos na Home em cards com fotos; aba Categorias em grid visual. Se a API informar `product_count=0`, setor oculto; na falta do campo, a API permanece responsável por filtrar setores vazios.
3. Banner principal prioriza `mobile_image_url` e `mobile_aspect_ratio` (ou `mobile_width`/`mobile_height`), exibindo imagem inteira, evitando cortar logo e laterais. Link HTTP(S) configurado no Admin pode ser aberto externamente.
4. Campanhas comuns e patrocinadas mantidas, inclusive identidade visual/skins e campanhas de datas especiais já suportadas na versão 1.6.34.
5. Produtos com dados explícitos de Clube (`offer_skin='clube'`, `club_exclusive`) recebem **faixa verde** em card e detalhe; não há cálculo de desconto ou mudança de preço local.
6. Sem preço de venda (`price<=0`), produto é omitido das listagens da Home, Ofertas, patrocinados e pesquisa. A decisão final de estoque/preço ainda é do servidor.
7. Conversão numérica de quantidades conforme padrão brasileiro: `1,000 = uma porção` e `1.000,000 = mil`, preservando multiplicador 0,500 kg e cálculo do faturamento.
8. Fluxos preexistentes conservados: autenticação Google nativa, CPF/CNPJ, endereços/CEP/localidade, produtos KG e opcionais, carrinho, ofertas, frete, agendamento, pagamentos, pedidos, SAC, LGPD, notificações, favoritos, biometria e Read Model.
9. Projeto white-label: o ZIP **não leva mais Dom Levi como identidade padrão**. Nome, package, logotipo, cores e versão são sincronizados do Admin Mobile do cliente no build.

## Ordem correta de implantação

1. Primeiro **instale e licencie no Ecommerce** o módulo Mobile no Soft Licenças, habilitando **Android**. O fato de ele aparecer no gerador não garante que a API já esteja publicada na loja.
2. Na loja: Admin > Mobile > Android/iOS. Configure o package ID definitivo da loja, ícone/logo, Google OAuth Android e **versão 1.6.35 / build 193** (ou uma numeração maior sem reutilizar um versionCode já publicado).
3. No Windows, instale Flutter SDK compatível (>=3.27), Android SDK, JDK 17 e execute `flutter doctor`.
4. Extraia este ZIP. Abra o **CMD ou PowerShell na pasta `soft_ecommerce_mobile_android`** e compile especificando a URL REAL da API do cliente.

### Exemplo para Carnes Mercês (confira o endpoint no servidor)

```bat
COMPILAR_ANDROID.cmd https://loja.carnesmerces.com.br/api/mobile/v1
```

O comando consulta o branding/release do Admin Mobile antes de compilar. Se o endpoint/identidade não estiver configurado, o processo deve falhar em vez de gerar um aplicativo com a marca de outro cliente.

Para gerar AAB, execute:

```bat
tooling\build_android_appbundle.cmd https://loja.carnesmerces.com.br/api/mobile/v1
```

O APK sai em `build/app/outputs/flutter-apk/app-release.apk`. O AAB sai em `build/app/outputs/bundle/release/app-release.aab`.

### Para rodar verificações no Windows

```bat
flutter pub get
flutter analyze
flutter test
```

**Importante:** este pacote foi montado e auditado estruturalmente, porém **não foi possível executar Flutter/Dart nem compilar Android neste ambiente**, porque esses SDKs não estão instalados aqui. Uma compilação local é obrigatória antes de homologar ou publicar.

## Android Google Login

O login Google da Web ter sido corrigido não ativa automaticamente o Android. O Client ID de Android deve ter o `package name` e SHA-1/SHA-256 da assinatura realmente utilizada, com configuração OAuth do projeto do Google. Preserve a keystore original de produção se este app já tiver sido publicado; **não substitua a assinatura para atualizar um aplicativo existente**.

## Clube de Descontos e preços

A base do Android está pronta para os campos `club`, `offer_skin`, `club_exclusive` e `club_caption`. A **API 1.14.5 histórica** não garantia esses campos. Sem `club.enabled=true` explícito, o atalho Clube não aparece. Isso evita apresentar adesão falsa, preço exclusivo a não associado ou mudar o subtotal no app. O Soft Ecommerce continua responsável por validar CPF/CNPJ, participação (AUTÔNOMO/INTEGRADO EMPORIUM), tabela, promoções e valor final no checkout.

## Atenção: regras comerciais

Frete grátis, taxas por localidade, bloqueio de feriados, corte diário, agendamento, formas de pagamento, Clube e parcelamento são **responsabilidade da API**. O app não decide valores nem ignora retornos de bloqueio. Se houver mudança recente na loja Web e ela ainda não estiver publicada na API Mobile, será necessária uma atualização **do backend Mobile** para equivalência integral. Veja `CONTRATO_API_MOBILE_NOV2026.md`.

Não substitua os arquivos PHP da loja por este ZIP: é exclusivamente o projeto Flutter/Android.
