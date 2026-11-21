# Android 1.6.35+193 — Interface mobile e compatibilidade com Ecommerce nov/2026

- Base: Android 1.6.34+192, API 1.14.5.
- Atalhos Home (Ofertas, Setores, Buscar, Pedidos, Carrinho e Clube condicional).
- Departamentos em cards com imagens, grid de categorias e filtro opcional por contagem de produtos.
- Banners mobile específicos, aspect ratio configurável, imagem sem corte de logo e links HTTP(S).
- Indicadores Clube verde nos cards e detalhe, sem criar preços/descontos no app.
- Produtos sem preço > 0 são omitidos das listagens exibidas no app.
- Parse de número BR com vírgula decimal e separador de milhares; preserva porções KG.
- Defaults white-label genéricos em vez da identidade da loja Dom Levi.
- Novos testes de compatibilidade em `test/mobile_november_2026_test.dart`.
- Necessita complemento futuro da API Mobile para expor clube/banner/contagem conforme contrato.
