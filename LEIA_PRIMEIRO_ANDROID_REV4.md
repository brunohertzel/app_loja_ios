# Android REV4 - 1.6.39+197

Atualizacao com base no projeto REV3 HOTFIX1, sem reescrever os fluxos comerciais.

## O que mudou
- Minha Conta exibe os atalhos sociais da loja quando a API disponibiliza links validos.
- Fale com a Loja apresenta os mesmos links da empresa, sem URLs artificiais.
- Sobre o App exibe as redes da desenvolvedora configuradas no Admin Mobile.
- Vitrine segue o parametro `vitrine.layout` da API: `departamentos` (blocos) ou `atual` (continua).
- Mantidos: ofertas, favoritos, patrocinados, cache, edicao de carrinho, GPS, PT/EN/ES.

## Aplicar em ordem
1. Instale PATCH_MOBILE_REV4 no Ecommerce e execute diagnostico.
2. Em Admin > Mobile > Geral, escolha `Seguir layout da loja Web` (padrao).
3. Em Admin > Mobile > Sobre o App, configure redes sociais da desenvolvedora e, se necessario, da loja.
4. Configure no Admin Mobile Android versao `1.6.39`, build `197`.
5. Extraia este ZIP e execute `COMPILAR_ANDROID.cmd https://loja.carnesmerces.com.br/api/mobile/v1`.
6. Verifique que o endpoint `/store/home.php` responde com `data.vitrine.layout`.

## Observacoes
- Não executei flutter analyze/flutter build neste ambiente. Execute no seu Windows.
- As redes da loja dependem do cadastro `web_empresas` e opcionalmente do override no Admin Mobile.
- Textos de produtos/campanhas continuam vindos do Ecommerce e nao sao traduzidos automaticamente.
- Se o painel Web usa uma chave de layout diferente de `web_vitrine_config.opcoes.layout`, o diagnostico mostrara a divergencia.
