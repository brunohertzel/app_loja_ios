import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soft_ecommerce_mobile/core/localization/message_catalog.dart';
import 'package:soft_ecommerce_mobile/core/localization/locale_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('os tres idiomas estao disponiveis', () {
    expect(AppLocaleController.supported.map((x) => x.languageCode),
        containsAll(['pt', 'en', 'es']));
  });

  test('mensagens de GPS em Portugues, Ingles e Espanhol', () {
    const key = 'Usar minha localização atual';
    expect(MessageCatalog.translate(key, 'pt'), key);
    expect(MessageCatalog.translate(key, 'en'), 'Use my current location');
    expect(MessageCatalog.translate(key, 'es'), 'Usar mi ubicación actual');
  });

  test('numero aproximado preserva numero e traduz a orientacao', () {
    const message = 'Número 123 sugerido pelo GPS: confirme ou corrija antes de salvar.';
    expect(MessageCatalog.translate(message, 'en'),
        contains('house number 123'));
    expect(MessageCatalog.translate(message, 'es'),
        contains('número 123'));
  });

  test('favoritos traduzidos sem mudar nomes comerciais do servidor', () {
    expect(MessageCatalog.translate('Meus itens favoritos', 'en'),
        'My favorite items');
    expect(MessageCatalog.translate('Meus itens favoritos', 'es'),
        'Mis artículos favoritos');
    expect(MessageCatalog.translate('KIT CHURRASCO PREMIUM', 'en'),
        'KIT CHURRASCO PREMIUM');
  });

  test('escolha manual do idioma persiste entre aberturas', () async {
    await AppLocaleController.instance.setLanguage('es');
    await AppLocaleController.instance.load();
    expect(AppLocaleController.instance.value.languageCode, 'es');
    await AppLocaleController.instance.setLanguage('en');
    expect(AppLocaleController.instance.value.languageCode, 'en');
  });
}
