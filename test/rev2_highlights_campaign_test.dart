import 'package:flutter_test/flutter_test.dart';
import 'package:soft_ecommerce_mobile/features/store/store_models.dart';

void main() {
  test('foto mobile do departamento prevalece sobre a arte desktop', () {
    final category = StoreCategory.fromJson({
      'id': '8',
      'name': 'Espetinhos',
      'mobile_image_url': 'https://exemplo.com/mobile.jpg',
      'image_url': 'https://exemplo.com/desktop.jpg',
      'image_status': 'ok',
    });
    expect(category.imageUrl, 'https://exemplo.com/mobile.jpg');
  });

  test('ofertas e campanhas patrocinadas nao sao misturadas', () {
    final home = StoreHomeData.fromJson({
      'data': {
        'offers': [
          {'id': '10', 'name': 'Oferta', 'price': 9.9},
        ],
        'sponsored_campaigns': [
          {
            'id': '22',
            'name': 'Natal',
            'visual_assets': [
              'https://exemplo.com/natal-mobile.jpg',
              'https://exemplo.com/natal-2.jpg',
            ],
            'products': [],
          }
        ],
        'categories': [], 'banners': [], 'products': [],
      }
    });
    expect(home.offers.length, 1);
    expect(home.sponsoredCampaigns.length, 1);
    expect(home.sponsoredCampaigns.first.visualAssets.length, 2);
  });
}
