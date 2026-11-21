import 'package:flutter_test/flutter_test.dart';
import 'package:soft_ecommerce_mobile/features/store/store_models.dart';

void main() {
  test('Vitrine continua quando o servidor informa layout atual', () {
    final home = StoreHomeData.fromJson({
      'data': {'vitrine': {'layout': 'atual'}, 'products': []},
    });
    expect(home.modularEnabled, isFalse);
  });

  test('Vitrine em blocos quando servidor informa departamentos', () {
    final home = StoreHomeData.fromJson({
      'data': {
        'vitrine': {
          'layout': 'departamentos',
          'departamentos_formato': 'grade',
          'departamentos_limite': 5,
          'produtos_por_departamento': 8,
        },
      },
    });
    expect(home.modularEnabled, isTrue);
    expect(home.departmentCarousel, isFalse);
    expect(home.departmentsLimit, 5);
    expect(home.productsPerDepartment, 8);
  });
}
