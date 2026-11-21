import 'package:flutter_test/flutter_test.dart';
import 'package:soft_ecommerce_mobile/features/store/store_models.dart';

void main() {
  test('quantidade brasileira: 1,000 e uma porcao e 1.000,000 sao mil', () {
    final rule = QuantityRules.fromJson({
      'unit': 'KG',
      'default_visual': '1,000',
      'default_real': '0,500',
      'step': 1,
      'minimum': 1,
      'has_quantity_variation': true,
    }, unit: 'KG');
    expect(rule.defaultVisual, 1);
    expect(rule.defaultReal, 0.5);
    final thousand = QuantityRules.fromJson({
      'default_visual': '1.000,000',
    });
    expect(thousand.defaultVisual, 1000);
  });

  test('produto KG preserva multiplicador de 500g', () {
    final option = ProductOption.fromJson({
      'id': 123, 'name': '500 g', 'affects_quantity': true,
      'quantity_multiplier': '0,500',
    });
    expect(option.affectsQuantity, isTrue);
    expect(option.quantityMultiplier, 0.5);
    expect(1000 * option.quantityMultiplier!, 500);
  });

  test('banner mobile tem prioridade e nao distorce proporcao', () {
    final b = StoreBanner.fromJson({
      'id': 'banner1', 'titulo': 'Natal',
      'image_url': 'desktop.jpg',
      'mobile_image_url': 'mobile.jpg',
      'mobile_width': 900,
      'mobile_height': 600,
    });
    expect(b.imageUrl, 'mobile.jpg');
    expect(b.aspectRatio, 1.5);
  });

  test('departamento sem produto declarado nao aparece', () {
    expect(StoreCategory.fromJson({'id': 1, 'name': 'Vazio',
      'product_count': 0}).shouldShow, isFalse);
    expect(StoreCategory.fromJson({'id': 2, 'name': 'Carnes',
      'product_count': 9}).shouldShow, isTrue);
    expect(StoreCategory.fromJson({'id': 3, 'name': 'Sem contagem'}).shouldShow, isTrue);
  });

  test('clube exige ativacao explicita do backend', () {
    final off = StoreClubInfo.fromJson({'enabled': false, 'member': true});
    final on = StoreClubInfo.fromJson({'enabled': true, 'mode': 'INTEGRADO_EMPORIUM',
      'member': false, 'join_url': 'https://example.org/clube'});
    expect(off.enabled, isFalse);
    expect(on.enabled, isTrue);
    expect(on.member, isFalse);
  });

  test('skin clube sinaliza mas nao inventa preco', () {
    final p = StoreProduct.fromJson({
      'id': 10, 'name': 'Corte', 'price': 42.5,
      'offer_skin': 'clube', 'club_exclusive': true,
    });
    expect(p.isClubVisual, isTrue);
    expect(p.price, 42.5);
    expect(p.hasOffer, isFalse);
  });

  test('home exclui produtos sem preco e preserva ofertas comuns', () {
    final h = StoreHomeData.fromJson({'data': {
      'products': [
        {'id': 1, 'name': 'Sem preco', 'price': 0},
        {'id': 2, 'name': 'Produto', 'price': 19.90},
      ],
      'offers': [
        {'id': 3, 'name': 'Oferta', 'price': 12, 'old_price': 15}
      ],
    }});
    expect(h.products.map((p) => p.id), ['2']);
    expect(h.offers.single.hasOffer, isTrue);
    expect(h.club, isNull);
  });
}
