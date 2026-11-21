# Contrato complementar — integração com o Soft Ecommerce de novembro/2026

## Estado real

A versão PHP Mobile 1.14.5 tem endpoints de catálogo, campanhas patrocinadas, pedidos, endereços e checkout. O Android 1.6.35 acrescenta reconhecimento de campos opcionais que precisam ser enviados pela API para refletir **todas** as funcionalidades da loja Web.

**Este documento não é uma migração de banco. Não altera licenciamento nem regras do ERP.**

## Exemplo dos novos campos opcionais de `GET /store/home.php`

```json
{
  "ok": true,
  "data": {
    "banners": [
      {
        "id": "campanha-natal",
        "title": "Neste Natal, sirva momentos inesquecíveis!",
        "image_url": "/uploads/banner-desktop.jpg",
        "mobile_image_url": "/uploads/banner-mobile.jpg",
        "mobile_aspect_ratio": 1.8,
        "link": "/loja/ofertas.php"
      }
    ],
    "categories": [
      {"id": "8", "name": "Carnes", "image_url": "/uploads/carnes.jpg", "product_count": 20}
    ],
    "club": {
      "enabled": true,
      "mode": "INTEGRADO_EMPORIUM",
      "member": false,
      "name": "Clube de Descontos",
      "description": "Adesão opcional. Consulte condições da loja.",
      "join_url": "https://sua-loja.exemplo/loja/minha_conta.php"
    },
    "products": [
      {"id": "100122", "name": "Corte por KG", "price": 64.90,
       "offer_skin": "clube", "club_exclusive": true,
       "club_caption": "Benefício sujeito à validação do Clube"}
    ]
  }
}
```

O exemplo documenta formato, **não é um retorno verificado de produção**. Não copie URLs fictícias, preço ou status de associação para uma loja real.

### Regras que precisam permanecer no backend

- `club.member` consultado pelo servidor com CPF/CNPJ autenticado; o app jamais concede benefício por flag local nem permite vincular outro CPF.
- `price` e `old_price` são o resultado comercial para o cliente; desconto não é calculado a partir do badge. `checkout/prepare.php` e `checkout/submit.php` recalculam tudo conforme a política do Ecommerce.
- As imagens e campanhas publicadas devem ser filtradas por período, canal, visibilidade, vínculo a produtos e disponibilidade.
- Departamentos sem produtos ativos com preço de venda devem ser filtrados na API, mesmo quando a API não enviar `product_count`.
- Endereços, entregas, feriados, corte de agendamento e disponibilidade devem sempre ser validados pelo servidor. O Android conserva a seleção que a API autoriza.
- Nenhum token OAuth/Google, chave Pagar.me, chave Soft Licenças ou credencial Firebird pode ser enviado nas respostas de configuração.

### Compatibilidade

Se os novos campos não forem enviados, o Android continua executando catálogo/campanhas existentes sem esses elementos. Isso é uma compatibilidade de leitura; **não é garantia de equivalência funcional** com todas as alterações da loja Web de novembro.

### Homologação recomendada

1. Confirmar `health.php` e `bootstrap.php` com licenciamento ANDROID e APIs de autenticação.
2. Comparar o mesmo produto/carrinho autenticado Web × Android, incluindo porção KG 500g e 1000 porções.
3. Testar cliente associado/não associado no Clube e preços no checkout (sem esconder preço normal para não associado).
4. Validar banner desktop/mobile, patrocinados, data especial, departamentos vazios e produtos sem preço.
5. Validar frete grátis carrinho/checkout, agendamento em feriados, retirada/delivery desabilitados e pagamento na entrega/PIX/cartão.
6. Confirmar o retorno de pedidos e cancelamentos, se habilitados, e persistência segura da sessão.
