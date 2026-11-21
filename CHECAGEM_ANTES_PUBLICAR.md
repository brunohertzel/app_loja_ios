# Checklist de liberação Android

- [ ] Módulo Mobile importado e licenciado no Ecommerce da loja; não só listado no Soft Licenças.
- [ ] URL `https://DOMINIO/api/mobile/v1/health.php` responde JSON (sem expor dados privados).
- [ ] Versão/build do Admin Mobile maiores que a publicação anterior.
- [ ] Package ID correto, sem trocar a keystore de um app que já está publicado.
- [ ] Credenciais OAuth Android (SHA-1/SHA-256) e login Google nativo testados.
- [ ] `flutter pub get`, `flutter analyze`, `flutter test` e compilação real executados.
- [ ] Catálogo/Read Model atualizado pelo worker, nunca via requisição do cliente.
- [ ] Campanhas e banners corretos nos tamanhos mobile; links funcionando.
- [ ] Clube membro/não membro, permissões, adesão e preços exclusivos validados pelo backend.
- [ ] Produtos sem preço, departamentos vazios e corte de imagens homologados.
- [ ] Quantidade KG `1,000=1` e 500g × número de porções corretamente faturados.
- [ ] Frete + checkout sem divergência, inclusive agendamento/feriados e retirada.
- [ ] PIX, cartão, dinheiro/troco e pagamento na entrega de acordo com configuração da loja.
- [ ] Push, pedidos, favoritos, conta, sessão, cadastro/CEP, biometria e privacidade testados.
- [ ] APK/AAB assinados com a identidade correta e avaliados em aparelho Android real.
