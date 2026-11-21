# Soft Ecommerce Mobile — REV5 GPS Cidade

Versão **1.6.40 + build 198** (base REV4 1.6.39 +197).

## Corrigido
- A geocodificação pode retornar `locality` como string vazia: o fallback com `??` falhava e deixava **Cidade** em branco.
- Pesquisa a cidade nos demais placemarks e, se necessário, em `subAdministrativeArea`, ignorando descrições de região metropolitana.
- Para CEP brasileiro válido, consulta **uma vez** o endpoint de CEP existente na API Mobile e prefere o município oficial do CEP quando a UF é compatível.
- Se a consulta falhar, não bloqueia o GPS; a pessoa continua podendo editar cidade, número, bairro e demais campos.
- Se ainda faltar município, mostra uma mensagem clara para preenchimento manual, traduzida em português, inglês e espanhol.
- Nenhuma mudança no servidor, no banco de dados, na licença ou nas configurações comerciais.

## Aplicação
Se já está usando a REV4, copie apenas os arquivos do **hotfix** para a raiz do projeto Flutter.
Ou extraia o ZIP completo e compile:
`COMPILAR_ANDROID.cmd https://loja.carnesmerces.com.br/api/mobile/v1`

Versão no Admin Mobile: **1.6.40**, build **198**.

## Validação
Execute `flutter analyze` e `flutter test test/rev5_gps_city_test.dart` antes de distribuir.
O ambiente que gerou este ZIP não possui Flutter SDK; a compilação Android precisa ser validada no Windows.
