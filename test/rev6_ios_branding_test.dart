import 'package:flutter_test/flutter_test.dart';
import 'package:soft_ecommerce_mobile/core/models/bootstrap_config.dart';
import 'package:soft_ecommerce_mobile/core/theme/app_theme.dart';

void main() {
  test('branding iOS da loja vem do bootstrap', () {
    final bootstrap = AppBootstrap.fromJson({
      'ok': true,
      'app': {
        'name': 'Carnes Mercês',
        'logo_url': 'https://example.org/logo.png',
        'icon_ios_url': 'https://example.org/icon-ios.png',
        'splash_url': 'https://example.org/splash.png',
        'primary_color': '#4F121A',
        'secondary_color': '#AE9456',
        'theme_default': 'SYSTEM',
      },
    });
    expect(bootstrap.app.name, 'Carnes Mercês');
    expect(bootstrap.app.logoUrl, 'https://example.org/logo.png');
    expect(bootstrap.app.iconIosUrl, 'https://example.org/icon-ios.png');
    expect(bootstrap.app.splashUrl, 'https://example.org/splash.png');
    expect(AppTheme.parseColor(bootstrap.app.primaryColor), isNotNull);
    expect(AppTheme.parseColor(bootstrap.app.secondaryColor), isNotNull);
    expect(bootstrap.app.primaryColor, '#4F121A');
    expect(bootstrap.app.secondaryColor, '#AE9456');
  });
}
