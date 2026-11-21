# Soft Ecommerce Android — REV1 (1.6.36 / build 194)

Projeto Flutter completo com alterações de interface e carrinho baseadas no Android 1.6.35+193.
Este pacote NÃO é um APK/AAB. Compile com o Flutter local e valide num aparelho antes de publicar.

## Alterações

1. **Fotos dos departamentos:** prioriza imagem mobile. Depende do patch de leitura da API (ZIP separado) para preencher o campo `image_url` com dados de `web_vitrine_departamentos`.
2. **Vitrine modular:** lê de `home.php` as opções `layout`, `departamentos_formato`, `departamentos_limite`, `produtos_por_departamento`; consulta os produtos de cada setor pela API, preservando contexto comercial. Faz carregamento em grupos de 4 requisições e respeita `exibir_home`. Sem o complemento da API, usa os parâmetros de compatibilidade (departamentos, carrossel, 8 setores, 10 itens).
3. **Campanhas patrocinadas:** texto legível em fundo neutro, sem sobreposição sobre a foto; apenas a identificação no cabeçalho da seção.
4. **Banner principal:** maior altura, imagem `BoxFit.cover`, preenchimento integral.
5. **Edição de carrinho:** botão "Editar produto", reabre o configurador com as seleções, números, observações e quantidade, valida os obrigatórios e substitui o lançamento anterior sem somá-lo indevidamente.
6. **Foto da campanha patrocinada:** `BoxFit.cover`, bloco sem moldura interna e com maior altura. Removido badge/skin "PATROCINADO" dos cartões de produtos da área.

## Instalação da API (necessária às fotos e opções de vitrine)

O complemento de servidor é distribuído SEPARADAMENTE como `SOFT_ECOMMERCE_MOBILE_API_PATCH_DEPARTAMENTOS_REV1.zip`.
Antes de instalá-lo, faça backup do site/banco; ele altera **somente**:
- `includes/mobile/functions_mobile_catalog_read.php` (decoração das categorias com imagens e ordem da Web)
- `api/mobile/v1/store/home.php` (leitura das preferências de vitrine da Web)

Os dois instaladores fazem backup dos arquivos originais em `../soft_mobile_backups` (fora da pasta pública `ecommerce`), validam a sintaxe PHP e abortam quando não reconhecem a estrutura atual. Não alteram MySQL, módulos, licenças ou configurações de pagamento.

1. Extraia `SERVIDOR_PATCH_CATEGORIAS/` dentro da raiz física do Ecommerce, ao lado de `api/`, `admin/` e `includes/`.
2. No PuTTY, estando na raiz do Ecommerce, execute **em uma linha**:

```bash
/opt/plesk/php/8.4/bin/php SERVIDOR_PATCH_CATEGORIAS/INSTALAR.php && /opt/plesk/php/8.4/bin/php SERVIDOR_PATCH_CATEGORIAS/INSTALAR_LAYOUT.php
```

3. Confira `https://loja.carnesmerces.com.br/api/mobile/v1/store/categories.php` (quando autorizado) e `store/home.php`: os departamentos devem vir com `image_url` e a Home com `data.vitrine`.
4. Se aparecer `Versao ... diferente`, pare; não substitua manualmente o PHP, pois a API atual pode ter evoluído.

## Compilação Windows

1. No Admin > Mobile > Android configure **1.6.36** e **194**, salve e confira a resposta de `bootstrap.php` antes de compilar.
2. Extraia a pasta `soft_ecommerce_mobile_android` em `C:\app_flutter\` (ou outra pasta local; não misture código com fontes antigos).
3. No terminal PowerShell/CMD, dentro da pasta do aplicativo, execute:

```bat
.\COMPILAR_ANDROID.cmd https://loja.carnesmerces.com.br/api/mobile/v1
```

4. O script usa **release** e gera `build\app\outputs\flutter-apk\app-release.apk`. A assinatura de produção continua dependendo do keystore original.
5. Para verificar análise/testes localmente, execute `flutter pub get`, `flutter analyze`, `flutter test` ANTES de publicar.

## Checklist mínimo de homologação

- Banner ocupa a largura e não mostra faixa branca; testar artes quadradas e horizontais.
- Fotos dos departamentos aparecem na Home e em Categorias; nomes, ordem e visibilidade do Admin coincidem.
- Blocos por departamento respeitam o formato (grade/carrossel), quantidade e ordem do Admin.
- Campanha patrocinada é legível com arte preenchendo o topo; não duplica badge nos produtos.
- Carrinho com duas configurações do mesmo SKU; editar uma; cancelar sem alterar; salvar com opções obrigatórias; editar porções de 500 g (1,000 porção = 0,500 KG).
- Autenticação, PIX/cartão, frete, retirada, agenda e Clube de Descontos continuam validados pelo servidor.

## Estado dos testes

- Revisão do código e arquivos-fonte; instaladores PHP passaram em `php -l` e foram testados em cópia do Mobile API 1.14.5, incluindo segunda execução idempotente.
- O Flutter SDK **não está instalado no ambiente usado para gerar este ZIP**; por isso não foi possível executar `flutter analyze`, `flutter test` ou gerar APK neste ambiente. O aplicativo deve ser compilado/validado na sua máquina antes de instalação pública.
- O módulo Mobile da loja pode estar diferente da base 1.14.5; o instalador do servidor aborta se detectar divergência.
