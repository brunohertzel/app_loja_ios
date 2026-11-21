# Carnes Mercês iOS — REV7 Hotfix 2 (Build 200)

## Problema identificado
O teste da barra compacta em telas de 320, 375 e 390 pontos não encontrava `Cat.` e no teste inglês não encontrava `Cats.`. O widget se baseava em `MediaQuery.sizeOf(context).width`, enquanto `tester.binding.setSurfaceSize(...)` muda as restrições de layout sem necessariamente atualizar o valor do MediaQuery no teste. Assim, o widget mostrava a etiqueta longa e os testes falhavam.

## Correção
`StoreBottomNavigation` utiliza `LayoutBuilder` e `constraints.maxWidth`, que representam a largura efetivamente oferecida à barra. Isso mantém as etiquetas abreviadas nas larguras inferiores a 430 pontos e completas em 430 pontos ou mais, com o mesmo comportamento na app real e no teste. Nenhum outro elemento da tela foi alterado.

## Aplicação sobre REV7 Hotfix 1
Extraia o ZIP **hotfix** diretamente em:
`C:\app_flutter\carnes_merces_ios_codemagic\`
Substitua o arquivo `lib/features/store/store_bottom_navigation.dart` e, se solicitado, o arquivo de teste.

No Git Bash:

```bash
cd /c/app_flutter/carnes_merces_ios_codemagic
git add lib/features/store/store_bottom_navigation.dart test/rev7_compact_navigation_test.dart LEIA_PRIMEIRO_IOS_REV7_HOTFIX2_LARGURA_NAV.md
git commit -m "iOS REV7 hotfix2: barra compacta usa largura real"
git push origin main
```

No Codemagic, inicie novo build da branch `main` e use o workflow **iOS sem certificado**.
A versão permanece **1.6.40 / build 200**, pois o build anterior falhou antes de gerar o IPA.

## Verificações
- Confirme o commit novo no build do Codemagic.
- O script deve executar `flutter test test/rev5_gps_city_test.dart test/rev6_ios_branding_test.dart test/rev7_compact_navigation_test.dart`.
- O comportamento esperado é passar os testes em 320, 375, 390 e 430 pontos e gerar `Carnes_Merces_1.6.40_200_UNSIGNED.ipa`.

**A compilação/testes Flutter ainda precisam ser executados no Codemagic.** Neste ambiente, somente a estrutura e a integridade dos arquivos foram verificadas.
