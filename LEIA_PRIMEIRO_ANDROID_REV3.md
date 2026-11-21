# Soft Ecommerce Android — REV3 (1.6.38 +196)

Base revisada: `1.6.37 +195 REV2`. Este ZIP tem o **projeto Flutter completo**; nao contem APK ou certificado de assinatura.

## Melhorias

1. Cache em disco para imagens publicas (vitrine, departamentos, produtos, banners e campanhas). Cache com periodo de revalidacao de 7 dias e limite aproximado de 350 arquivos; o proprio SO pode remover arquivos para liberar espaco. Precarrega, de forma sequencial e limitada, ate 12 fotos iniciais enquanto o app estiver aberto. Nenhum servico de localizacao ou download persistente fora do app e iniciado.
2. Favoritos exibidos com o MESMO grid e card visual usado na loja: foto, titulo, promocao, Clube, preco, KG/variacoes e botao de carrinho. O coracao permite desfavoritar e atualiza a lista.
3. Cadastro de endereco: botao **Usar minha localizacao atual**. Pede permissao apenas ao tocar, consulta uma unica vez, faz geocodificacao reversa no aparelho e mostra sugestao de rua, bairro, cidade, UF, CEP e **numero aproximado quando houver**. Antes de preencher, mostra dialogo; todos os campos continuam editaveis e a API continua validando bairro/frete. Se nao obtiver numero ou CEP, usuario informa manualmente.
4. Idiomas: Portugues do Brasil, Ingles e Espanhol. No primeiro acesso usa idioma do aparelho, com fallback para Portugues; selecao manual em **Conta > Configuracoes Locais e Seguranca > Idioma**. Incluidas traducoes para mensagens novas de GPS, numero aproximado e favoritos. Produtos/campanhas e textos do servidor sao apresentados no idioma cadastrado, sem traducao automatica.
5. Permissoes Android: `ACCESS_COARSE_LOCATION` / `ACCESS_FINE_LOCATION`, somente para sugerir endereco, sem permissao de localizacao em segundo plano.

## Compilar no Windows

1. Substitua a pasta do projeto Android pela pasta `soft_ecommerce_mobile_android` do ZIP (salve os arquivos de assinatura/`key.properties` existentes **fora** da pasta antes).
2. Na loja: **Admin > Mobile > Android**: versao **1.6.38** e build **196**, caso esta seja a proxima versao destinada a instalacao.
3. Com Flutter >= 3.27 e SDK Android:

   ```bat
   .\COMPILAR_ANDROID.cmd https://loja.carnesmerces.com.br/api/mobile/v1
   ```

   O script busca release, branding e URL da API diretamente no servidor, faz `flutter clean`, `flutter pub get` e `flutter build apk --release`.

4. Para validacao antes de instalar:

   ```bat
   flutter pub get
   flutter analyze
   flutter test
   ```

5. APK esperado: `build\app\outputs\flutter-apk\app-release.apk`.

## Regressao obrigatoria

- Voltar da busca/conta/favoritos para a Home: fotos reaparecem sem baixar de novo enquanto o cache estiver valido.
- Wi-Fi e dados moveis; alternar rede e testar sem conectividade depois de visualizar a vitrine.
- Trocar produto favorito e verificar cards/quantidades/precos do Clube e KG.
- GPS com permissao aceita/negada/bloqueada; numero existente/ausente, CEP ausente, endereco fora da area e localidades especiais.
- Trocar idiomas PT/EN/ES, fechar e abrir o aplicativo e conferir persistencia.
- Conferir assinatura e package id antes de publicar na Play Store.

**Nota de seguranca:** cache de imagens publicas, nao das credenciais do cliente; imagens privadas de perfil continuam em memoria sem persistencia no gerenciador de imagens. A localizacao e capturada apenas quando solicitada, nao monitorada continuamente.

**Teste local:** arquivos e contratos estaticos conferidos. O SDK Flutter nao estava disponivel no ambiente de preparacao; `flutter analyze`, `flutter test` e APK devem ser executados no Windows. O ZIP **nao substitui a API Mobile** nem altera o modulo no Soft Licencas.
