import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soft_ecommerce_mobile/features/cart/cart_controller.dart';
import 'package:soft_ecommerce_mobile/features/store/store_models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('categorias priorizam imagem mobile, titulo e ordem da API', () {
    final category = StoreCategory.fromJson({
      'id': '3', 'name': 'AVES', 'section_title': 'Aves especiais',
      'mobile_image_url': 'https://site.test/mobile.webp',
      'image_url': 'https://site.test/desktop.webp', 'show_home': false,
    });
    expect(category.imageUrl, 'https://site.test/mobile.webp');
    expect(category.sectionTitle, 'Aves especiais');
    expect(category.showHome, isFalse);
    expect(category.shouldShow, isTrue);
  });

  test('vitrine modular respeita opcoes da loja', () {
    final home = StoreHomeData.fromJson({'data': {
      'vitrine': {
        'layout': 'departamentos', 'departamentos_formato': 'grade',
        'departamentos_limite': 7, 'produtos_por_departamento': 12,
      },
    }});
    expect(home.modularEnabled, isTrue);
    expect(home.departmentCarousel, isFalse);
    expect(home.departmentsLimit, 7);
    expect(home.productsPerDepartment, 12);
  });

  test('editar configuracao substitui item existente sem duplicar', () async {
    final cart = CartController();
    await cart.load();
    final product = StoreProduct.fromJson({
      'id': '100122', 'name': 'Posta vermelha KG', 'price': 80,
      'unit': 'KG',
    });
    cart.addConfigured(
      product: product, quantityVisual: 2, quantityReal: 1,
      quantityMultiplier: 0.5,
      selectedVariationIds: const [1], numberValues: const {},
      observation: '', observationSummary: '500 g',
    );
    final original = cart.items.single.lineId;
    expect(cart.updateConfigured(
      originalLineId: original,
      product: product,
      quantityVisual: 3, quantityReal: 3,
      selectedVariationIds: const [2], numberValues: const {},
      observation: 'Sem gordura', observationSummary: '1 KG, Sem gordura',
    ), isTrue);
    expect(cart.itemCount, 1);
    expect(cart.items.single.selectedVariationIds, [2]);
    expect(cart.items.single.quantityVisual, 3);
    expect(cart.items.single.quantityReal, 3);
    expect(cart.items.single.observation, 'Sem gordura');
    expect(cart.items.single.lineId, isNot(original));
  });

  test('editar para uma configuracao existente unifica sem sumir com quantidades', () async {
    final cart = CartController();
    await cart.load();
    final p = StoreProduct.fromJson({'id': '5', 'name': 'Kit', 'price': 50});
    cart.addConfigured(product: p, quantityVisual: 1, quantityReal: 1,
      selectedVariationIds: const [1], numberValues: const {},
      observation: '', observationSummary: 'A');
    cart.addConfigured(product: p, quantityVisual: 2, quantityReal: 2,
      selectedVariationIds: const [2], numberValues: const {},
      observation: '', observationSummary: 'B');
    final old = cart.items.firstWhere((l) => l.selectedVariationIds.contains(1));
    expect(cart.itemCount, 2);
    expect(cart.updateConfigured(originalLineId: old.lineId, product: p,
      quantityVisual: 3, quantityReal: 3,
      selectedVariationIds: const [2], numberValues: const {},
      observation: '', observationSummary: 'B'), isTrue);
    expect(cart.itemCount, 1);
    expect(cart.items.single.quantityReal, 5);
  });
}
