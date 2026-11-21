# Carnes Mercês iOS — REV7: navegação compacta (1.6.40 build 200)

## Problema observado
No iPhone 6s e em aparelhos de largura reduzida, a barra inferior padrão do Flutter distribuía seis destinos e quebrava os nomes **Categorias**, **Favoritos** e **Carrinho** em duas linhas. Os textos invadiam a área de conteúdo e pareciam desalinhados.

## Correção
- Substituição **somente da barra de navegação da Home** por componente responsivo, mantendo **seis** destinos na mesma ordem: Ofertas, Categorias, Loja, Favoritos, Carrinho, Conta.
- Em larguras inferiores a 430 pontos lógicos (ou fonte do sistema aumentada), textos curtos em linha única (Cat., Fav., Carr.) e ajuste de escala sem quebra de linha.
- Para telas maiores, nomes completos, também em uma linha.
- Ícone **Loja** continua destacado; badge do Carrinho e foto da Conta preservados.
- Barra utiliza SafeArea e respeita a área inferior do iPhone.
- Acessibilidade: rótulo **completo** para VoiceOver, mesmo nos botões abreviados.
- Textos compactos adaptados a português, inglês e espanhol.
- Preservados identidade visual via API, splash, catálogo, preços, campanhas, favoritos, GPS, checkout e licença.

## Hotfix sobre REV6
Extrair o ZIP hotfix com a estrutura de diretórios dentro de:

`C:\app_flutter\carnes_merces_ios_codemagic`

Apenas estes arquivos são substituídos/adicionados:

- `lib/features/store/store_shell.dart` (substituição da NavigationBar)
- `lib/features/store/store_bottom_navigation.dart` (novo componente)
- `pubspec.yaml` (build 200)
- `codemagic.yaml` (build 200 + teste de layout)
- `test/rev7_compact_navigation_test.dart` (testes de 320, 375, 390 e 430 pontos)
- `LEIA_PRIMEIRO_IOS_REV7_NAVEGACAO_COMPACTA.md`

## Publicar no GitHub (somente iOS)
Abrir Git Bash e executar:

```bash
cd /c/app_flutter/carnes_merces_ios_codemagic
git add lib/features/store/store_shell.dart lib/features/store/store_bottom_navigation.dart pubspec.yaml codemagic.yaml test/rev7_compact_navigation_test.dart LEIA_PRIMEIRO_IOS_REV7_NAVEGACAO_COMPACTA.md
git commit -m "iOS REV7: barra inferior responsiva build 200"
git push origin main
```

Repositorio: `https://github.com/brunohertzel/app_loja_ios`

## Codemagic
Workflow: **Carnes Merces - iOS sem certificado (IPA para Sideloadly)**.

O Codemagic gera `Carnes_Merces_1.6.40_200_UNSIGNED.ipa` para assinar e instalar como você já fez no iPhone.

## Testes
O workflow chama `flutter test test/rev7_compact_navigation_test.dart` juntamente com os testes de GPS e identidade visual. **Os testes Dart/Flutter devem ser executados no Codemagic**, pois o SDK Flutter não está disponível neste ambiente de geração. O ZIP foi validado localmente quanto à estrutura, imports e integridade; o resultado do build no dispositivo ainda precisa ser conferido.
