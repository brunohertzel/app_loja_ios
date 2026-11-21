# Android REV2 — compilacao

1. Instale **antes** o hotfix API Mobile REV2 no ecommerce. Rode `DIAGNOSTICAR.php` para conferir as fotos antes de recompilar.
2. No Admin > Mobile > Android, configure versao **1.6.37** e build **195** (inteiro), mantendo o package ID e a mesma chave de assinatura das versoes anteriores.
3. Descompacte este ZIP no Windows; entre na pasta `soft_ecommerce_mobile_android`.
4. Execute: `COMPILAR_ANDROID.cmd https://loja.carnesmerces.com.br/api/mobile/v1` (ajuste dominio conforme seu cliente).
5. O script principal de compilacao gera release; verifique assinatura antes da distribuicao. Para Play Store, use um AAB assinado com a chave de upload correta.
6. Execute `flutter analyze` e `flutter test`. Verifique login, ofertas, favoritos (com e sem login), navegacao, banner, campanhas, departamentos e edicao de carrinho.

## Diagnostico imagens

O modulo Web salva fotos em `web_vitrine_departamentos`, e os arquivos em `admin/uploads/departamentos` (ou caminho legado). O hotfix REV2 devolve `image_url` e `image_status` em `/api/mobile/v1/store/categories.php` e `/api/mobile/v1/store/home.php`.

- `ok`: arquivo encontrado no servidor; abra a URL retornada no navegador para testar HTTP 200.
- `sem_foto_cadastrada`: envie a foto pelo Admin.
- `arquivo_nao_encontrado`: o registro aponta para arquivo ausente (verificar publicacao/upload/permissoes).
- `sem_cadastro_visual`: sem linha correspondente para a origem/ID configurados na vitrine (verifique `departamento_site_tipo`).

Se houver URL mas ela retornar 403/404, o Flutter nao pode recuperar a imagem sozinho: corrija a URL/permissao no servidor.
