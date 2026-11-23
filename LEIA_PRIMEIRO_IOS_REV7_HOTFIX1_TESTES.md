# Carnes Mercês iOS — REV7 Hotfix 1 (teste de localização)

## Erro do Codemagic
O teste `rev7_compact_navigation_test.dart` criava um `MaterialApp` para simular a barra inferior sem registrar os delegates de tradução. O Flutter emitia:
`Warning: This application's locale, pt_BR, is not supported by all of its localization delegates.`
O teste verificava `tester.takeException() == null`, então o aviso fazia os casos de layout falharem antes da compilação.

## Correção
- Importado `package:flutter_localizations/flutter_localizations.dart`.
- Adicionados os mesmos três delegates do `lib/app.dart`: Material, Widgets e Cupertino.
- Adicionado `pumpAndSettle()` após a montagem de idiomas e badge.
- Nenhuma alteração de layout, regras comerciais, API, iOS target ou assinatura.
- Mantidos versão **1.6.40** e build **200** (é uma correção somente de teste).

## Aplicar no projeto existente
Extraia este ZIP dentro de:
`C:\app_flutter\carnes_merces_ios_codemagic`
Substitua `test/rev7_compact_navigation_test.dart`.

No Git Bash:
```bash
cd /c/app_flutter/carnes_merces_ios_codemagic
git add test/rev7_compact_navigation_test.dart
git commit -m "iOS REV7: corrigir teste de localizacao pt_BR"
git push origin main
```
Inicie um novo build no Codemagic (workflow sem certificado).

## Validação
Conferidas por análise estática as importações, os delegates e as configurações de localização no código real. Sem SDK Flutter instalado aqui; o resultado efetivo de `flutter test` depende do próximo build no Codemagic. Se ainda houver falha, copie a primeira exceção completa do novo log.
