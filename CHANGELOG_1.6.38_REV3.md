# Android 1.6.38 + 196 — REV3 (19/11/2026)

Base: Android 1.6.37 + 195 REV2.

- Cache persistente de imagens publicas por 7 dias; limite de 350 arquivos;
  reutilizacao entre abas e reinicios do app; preload sequencial e limitado
  das primeiras 12 imagens de home/campanhas/departamentos/ofertas enquanto
  o aplicativo esta aberto. Imagens continuam sujeitas a atualizacao por URL
  ou revalidacao de cache e o cache pode ser excluido pelo sistema.
- Todos os cards, banners, fotos de produto e avatares remotos passam
  pelo mesmo gerenciador de cache. Nao cacheia endpoints privados da API.
- Favoritos passam a usar EXATAMENTE o card visual e de precos da vitrine:
  KG/porcao, Clube, ofertas, imagem, favoritar e acao de compra.
- Formularios de endereco (Conta, novo endereco, cadastro quando reutilizado)
  incluem "Usar minha localizacao atual": permissao somente ao tocar,
  localizacao pontual, geocodificacao reversa Android, sugestao inclusive
  de numero se o sistema fornecer, dialogo de confirmacao e todos os
  campos editaveis antes do salvamento. Regras de frete/CEP/bairro continuam
  validadas pela API; GPS nao altera regras comerciais.
- Novas dependencias no pubspec: cached_network_image, flutter_cache_manager,
  geolocator, geocoding. O `flutter pub get` da primeira compilacao
  precisara de acesso ao pub.dev.

## Homologacao obrigatoria
`flutter pub get`, `flutter analyze`, `flutter test` e build Release no seu Windows.
Testar permissao GPS negada e aceita, endereco com e sem numero, produto com
preco KG, favoritos, modo offline e retorno da Home.

## Idiomas
- Português (Brasil), Inglês e Espanhol, sem nova API. O idioma inicial segue
  a configuração do aparelho, com fallback para Português; a escolha manual
  permanece salva em Configurações Locais e Segurança > Idioma.
- Traduções dos novos fluxos de localização/GPS, número aproximado, confirmação
  de endereço, mensagens de permissão, favoritos e carrinho.
- Nomes de produtos, campanhas e avisos legais entregues pela loja permanecem
  iguais aos dados cadastrados no servidor (não faz tradução automática de
  conteúdo administrativo).
