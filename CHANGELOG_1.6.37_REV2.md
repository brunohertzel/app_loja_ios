# Soft Ecommerce Android 1.6.37 + 195 — REV2 (18/11/2026)

Base: 1.6.36 + 194 REV1. Mantidas as regras de carrinho/edicao, KG, Clube, checkout e integracao API.

- **Home:** duas faixas de destaque — ofertas oficiais e favoritos do cliente, usando somente precos e produtos retornados pela API.
- **Favoritos:** menu inferior com coracao, acesso autenticado, favoritos carregados no servidor e atualizados ao retornar para a Loja ou tocar o coracao nos destaques.
- **Loja:** icone da navegacao inferior maior (30px normal/36px selecionado).
- **Para voce:** removida a lista generica; favoritos identificados como tal. Busca, Ofertas e Categorias continuam disponiveis.
- **Campanhas:** imagens oficiais passam em carrossel automatico a cada 5 segundos, com gesto de deslizar, indicadores e `BoxFit.cover`; sponsor logo nao vira uma arte adicional por engano.
- **Departamentos:** continua usando `mobile_image_url` antes de `image_url`; requer hotfix API REV2 separado para corrigir resolucao do caminho das fotos cadastradas na Web.

As ofertas e campanhas continuam sujeitas exclusivamente ao preco/validacao devolvidos pelo servidor.

**Nao validado neste ambiente:** `flutter analyze`, `flutter test`, build APK/AAB e testes em aparelho real — executar no computador com SDK Flutter.
