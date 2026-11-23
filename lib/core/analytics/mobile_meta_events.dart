import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';

/// Eventos publicitarios opcionais: por padrao DESLIGADOS.
/// Envia somente eventos aprovados e apenas apos consentimento explicito.
/// Nao coleta IDFA/GAID, GPS, e-mail, telefone nem dados de pagamento.
class MobileMetaEvents {
  static const String _consentKey = 'soft_mobile_marketing_consent_v1';
  static const String _installKey = 'soft_mobile_marketing_install_v1';
  static bool _featureEnabled = false;
  static final Random _random = Random.secure();

  static void configure({required bool mobileAds, required bool attribution}) {
    _featureEnabled = mobileAds && attribution;
  }

  static Future<bool> hasConsent() async {
    try {
      final p = await SharedPreferences.getInstance();
      return p.getBool(_consentKey) == true;
    } catch (_) { return false; }
  }

  static Future<void> setConsent(bool enabled) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_consentKey, enabled);
    // Ao revogar, a proxima autorizacao cria uma identidade aleatoria nova.
    if (!enabled) await p.remove(_installKey);
  }

  static String _id([int size = 20]) =>
      List<int>.generate(size, (_) => _random.nextInt(256))
          .map((v) => v.toRadixString(16).padLeft(2, '0')).join();

  static Future<void> track(ApiClient api, String event, {
    Map<String, dynamic> payload = const <String, dynamic>{},
  }) async {
    if (!_featureEnabled || !await hasConsent()) return;
    const allowed = {'product_viewed', 'search_performed', 'cart_item_added', 'checkout_started'};
    if (!allowed.contains(event)) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      var install = prefs.getString(_installKey) ?? '';
      if (install.isEmpty) {
        install = _id();
        await prefs.setString(_installKey, install);
      }
      await api.post('/metrics/event.php', <String, dynamic>{
        'event': event,
        'payload': <String, dynamic>{
          ...payload,
          'marketing_consent': true,
          'event_id': _id(),
          'install_id': install,
        },
      }, timeout: const Duration(seconds: 5));
    } catch (_) {
      // Analytics nao deve travar o app nem interferir no checkout.
    }
  }
}
