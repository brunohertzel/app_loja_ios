import '../../core/config/platform_info.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';
import '../../core/localization/locale_controller.dart';
import '../../core/localization/localized_widgets.dart';
import 'store_models.dart';
import 'gps_city_resolver.dart';

typedef AddressRulesLoader = Future<Map<String, dynamic>> Function(
    Map<String, dynamic> address, bool lookupZip);

/// Cadastro e Conta usam o mesmo formulário e a mesma validação do servidor.
class AddressForm extends StatefulWidget {
  const AddressForm(
      {super.key,
      required this.loadRules,
      this.address,
      this.enabled = true,
      this.showLabel = false,
      this.ruleContext = ''});
  final AddressRulesLoader loadRules;
  final Map<String, dynamic>? address;
  final bool enabled, showLabel;
  final String ruleContext;
  @override
  State<AddressForm> createState() => AddressFormState();
}

class AddressFormState extends State<AddressForm> {
  final _form = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _fields;
  bool _loading = false, _lookup = false, _filling = false, _geoChecking = false;
  String? _geoMessage;
  String? _error, _rulesKey;
  String _ibge = '';
  int? _locality;
  int _request = 0;
  Timer? _debounce;
  Map<String, dynamic> _rules = {};
  String get _key => [
        widget.ruleContext,
        ...['zip', 'city', 'state']
            .map((k) => _fields[k]!.text.trim().toUpperCase())
      ].join('|');
  bool get _canConsult =>
      RegExp(r'^\d{8}$').hasMatch(_fields['zip']!.text) &&
      _fields['city']!.text.trim().isNotEmpty &&
      _fields['state']!.text.trim().length == 2;
  bool get _requiresLocality => boolValue(_rules['use_select']);

  @override
  void initState() {
    super.initState();
    _fields = {
      for (final key in [
        'label',
        'zip',
        'street',
        'number',
        'complement',
        'district',
        'city',
        'state'
      ])
        key: TextEditingController(
            text: key == 'zip'
                ? stringValue(widget.address?[key])
                    .replaceAll(RegExp(r'\D'), '')
                : stringValue(widget.address?[key]))
    };
    _ibge = stringValue(widget.address?['city_ibge']);
    final id = int.tryParse(stringValue(widget.address?['locality_id']));
    _locality = id != null && id > 0 ? id : null;
    for (final key in ['zip', 'city', 'state']) {
      _fields[key]!.addListener(_changed);
    }
    _load();
  }

  @override
  void didUpdateWidget(covariant AddressForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.ruleContext != oldWidget.ruleContext) _changed();
  }

  void _changed() {
    if (_filling) return;
    _debounce?.cancel();
    ++_request;
    setState(() {
      _rulesKey = null;
      _rules = {};
      _locality = null;
      _ibge = '';
      _loading = false;
      _lookup = false;
      _error = null;
    });
    if (_canConsult)
      _debounce = Timer(const Duration(milliseconds: 500), _load);
  }

  void _apply(Map<String, dynamic> json, {bool fill = false}) {
    _filling = true;
    if (fill) {
      final address = mapValue(json['address']);
      for (final k in ['street', 'district', 'city', 'state']) {
        final value = stringValue(address[k]);
        if (value.isNotEmpty) _fields[k]!.text = value;
      }
      _ibge = stringValue(address['city_ibge']);
      _locality = null;
    }
    _filling = false;
    _rules = mapValue(json['rules']);
    _rulesKey = _key;
    _ibge = stringValue(_rules['city_ibge'], fallback: _ibge);
    final items = listValue(_rules['localities']);
    if (!_requiresLocality)
      _locality = null;
    else if (!items
        .any((l) => int.tryParse(stringValue(l['id'])) == _locality)) {
      // Endereço existente: nome exato, único, entre as opções ainda ativas.
      final matches = items
          .where((l) =>
              stringValue(l['name']).trim().toLowerCase() ==
              _fields['district']!.text.trim().toLowerCase())
          .toList();
      _locality = matches.length == 1
          ? int.tryParse(stringValue(matches.single['id']))
          : null;
    }
    if (_requiresLocality && _locality != null)
      _fields['district']!.text = stringValue(items.firstWhere(
          (l) => int.tryParse(stringValue(l['id'])) == _locality)['name']);
  }

  Future<bool> _load({bool lookup = false}) async {
    _debounce?.cancel();
    if (lookup
        ? !RegExp(r'^\d{8}$').hasMatch(_fields['zip']!.text)
        : !_canConsult) {
      if (mounted)
        setState(() {
          _loading = false;
          _error = lookup ? tr('Informe os 8 dígitos do CEP.') : null;
        });
      return false;
    }
    final key = _key, request = ++_request;
    setState(() {
      _loading = true;
      _lookup = lookup;
      _error = null;
    });
    try {
      final json = await widget.loadRules({
        for (final k in ['zip', 'city', 'state']) k: _fields[k]!.text.trim(),
        'city_ibge': _ibge
      }, lookup);
      if (!mounted || request != _request || key != _key) return false;
      setState(() => _apply(json, fill: lookup));
      return true;
    } catch (e) {
      if (mounted && request == _request)
        setState(() {
          _error = '$e';
          _rulesKey = null;
        });
      return false;
    } finally {
      if (mounted && request == _request)
        setState(() {
          _loading = false;
          _lookup = false;
        });
    }
  }

  static const Map<String, String> _stateCodes = {
    'acre': 'AC', 'alagoas': 'AL', 'amapa': 'AP', 'amazonas': 'AM',
    'bahia': 'BA', 'ceara': 'CE', 'distrito federal': 'DF',
    'espirito santo': 'ES', 'goias': 'GO', 'maranhao': 'MA',
    'mato grosso': 'MT', 'mato grosso do sul': 'MS',
    'minas gerais': 'MG', 'para': 'PA', 'paraiba': 'PB',
    'parana': 'PR', 'pernambuco': 'PE', 'piaui': 'PI',
    'rio de janeiro': 'RJ', 'rio grande do norte': 'RN',
    'rio grande do sul': 'RS', 'rondonia': 'RO', 'roraima': 'RR',
    'santa catarina': 'SC', 'sao paulo': 'SP', 'sergipe': 'SE',
    'tocantins': 'TO',
  };

  String _normalizeState(String value) {
    final normalized = value.toLowerCase().trim()
        .replaceAll(RegExp('[áàâã]'), 'a')
        .replaceAll(RegExp('[éê]'), 'e')
        .replaceAll(RegExp('[í]'), 'i')
        .replaceAll(RegExp('[óôõ]'), 'o')
        .replaceAll(RegExp('[ú]'), 'u')
        .replaceAll('ç', 'c');
    if (value.trim().length == 2) return value.trim().toUpperCase();
    return _stateCodes[normalized] ?? '';
  }

  /// Permissao solicitada apenas quando o cliente toca no botao.
  /// Geocoding do aparelho pode sugerir numero aproximado; usuario revisa.
  Future<void> _useCurrentLocation() async {
    if (_geoChecking || !widget.enabled) return;
    setState(() { _geoChecking = true; _geoMessage = null; _error = null; });
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw StateError('Ative a localização do aparelho para preencher o endereço.');
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        throw StateError(PlatformInfo.isIOS
            ? 'Permissão de localização bloqueada. Autorize nos Ajustes do iPhone ou digite o endereço.'
            : 'Permissão de localização bloqueada. Autorize nas configurações do Android ou digite o endereço.');
      }
      if (permission == LocationPermission.denied) {
        throw StateError('Localização não autorizada. Você pode cadastrar o endereço manualmente.');
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 18),
        ),
      );
      // geocoding >= 3.0: locale is configured separately, not passed to
      // placemarkFromCoordinates. Keep pt_BR for Brazilian addresses/CEP.
      await setLocaleIdentifier('pt_BR');
      final places = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      ).timeout(const Duration(seconds: 12));
      if (places.isEmpty) {
        throw StateError('Não foi possível identificar o endereço próximo. Preencha manualmente.');
      }
      if (!mounted) return;
      // Alguns provedores retornam locality='' (não null), enquanto outros
      // informam a cidade apenas nos placemarks seguintes. Nunca usar
      // 'Região Metropolitana' como se fosse o município.
      final p = places.first;
      if (p.isoCountryCode != null && p.isoCountryCode!.isNotEmpty &&
          p.isoCountryCode!.toUpperCase() != 'BR') {
        throw StateError('A localização retornou um endereço fora do Brasil. Confira o endereço manualmente.');
      }
      final number = (p.subThoroughfare ?? '').trim();
      final suggestedNumber = RegExp(r'^\d+[A-Za-z]?$').hasMatch(number) ? number : '';
      final zip = (p.postalCode ?? '').replaceAll(RegExp(r'\D'), '');
      var city = resolveGpsCity(
        localities: places.map((place) => place.locality),
        subAdministrativeAreas: places.map((place) => place.subAdministrativeArea),
      );
      var state = _normalizeState(p.administrativeArea ?? '');
      var street = (p.thoroughfare ?? '').trim();
      var district = (p.subLocality ?? '').trim();
      // O CEP cadastrado na própria API do Ecommerce é a fonte principal
      // para o município. É UMA consulta por toque do cliente (nunca polling).
      // Se o CEP ou a rede falhar, mantém o endereço aproximado do GPS.
      if (zip.length == 8 && zip != '00000000') {
        try {
          final lookedUp = await widget.loadRules({
            'zip': zip,
            'city': city,
            'state': state,
            'city_ibge': '',
          }, true).timeout(const Duration(seconds: 10));
          if (!mounted) return;
          final address = mapValue(lookedUp['address']);
          final zipCity = stringValue(address['city']).trim();
          final zipState = _normalizeState(stringValue(address['state']));
          if (zipState.isNotEmpty && state.isEmpty) state = zipState;
          city = preferZipCity(
            gpsCity: city,
            zipCity: zipCity,
            gpsState: state,
            zipState: zipState,
          );
          if (street.isEmpty) street = stringValue(address['street']).trim();
          if (district.isEmpty) district = stringValue(address['district']).trim();
        } catch (_) {
          // A consulta ao CEP é complementar: não interromper o cadastro.
        }
      }
      final suggested = <String, String>{
        'zip': zip.length == 8 && zip != '00000000' ? zip : '',
        'street': street,
        'number': suggestedNumber,
        'district': district,
        'city': city,
        'state': state,
      };
      if (!suggested.values.any((v) => v.isNotEmpty)) {
        throw StateError('A localização não retornou dados de endereço. Digite manualmente.');
      }
      final preview = [
        if (suggested['street']!.isNotEmpty) suggested['street']!,
        if (suggestedNumber.isNotEmpty) '${tr('Número aproximado')}: $suggestedNumber',
        if (suggested['district']!.isNotEmpty) suggested['district']!,
        if (suggested['city']!.isNotEmpty) '${suggested['city']} - ${suggested['state']}',
        if (suggested['zip']!.isNotEmpty) 'CEP ${suggested['zip']}',
      ].join(', ');
      final apply = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const LText('Usar endereço aproximado?'),
          content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            LText(preview, translate: false),
            const SizedBox(height: 12),
            const LText('A localização pode sugerir o número da rua. Confira e corrija o número, CEP e complemento antes de salvar.'),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const LText('Cancelar')),
            FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const LText('Usar e ajustar')),
          ],
        ),
      );
      if (!mounted || apply != true) return;
      // Atualiza todos juntos, sem disparar consultas intermediarias.
      _filling = true;
      for (final field in suggested.entries) {
        // Ausencia de numero nao deve reutilizar o numero de outro endereco.
        if (field.key == 'number') {
          _fields['number']!.text = field.value;
        } else if (field.value.isNotEmpty) {
          _fields[field.key]!.text = field.value;
        }
      }
      _filling = false;
      _changed();
      if (mounted) setState(() => _geoMessage = city.isEmpty
          ? 'A localização não identificou a cidade. Informe a cidade e confira o endereço antes de salvar.'
          : suggestedNumber.isNotEmpty
              ? 'Número $suggestedNumber sugerido pelo GPS: confirme ou corrija antes de salvar.'
              : 'Localização aproximada preenchida. Informe o número e confira os demais campos.');
    } catch (e) {
      // Erros conhecidos apresentam instrucao localizavel; falhas do GPS ou
      // da rede nao devem mostrar mensagens internas do plugin ao cliente.
      final message = e is StateError
          ? e.message.toString()
          : 'Não foi possível obter a localização agora. Você pode digitar o endereço manualmente.';
      if (mounted) setState(() => _geoMessage = message);
    } finally {
      if (mounted) setState(() => _geoChecking = false);
    }
  }

  /// Confirma regras atuais antes de validar e devolver valores canônicos.
  Future<Map<String, dynamic>?> read() async {
    if (!_canConsult) {
      _form.currentState?.validate();
      return null;
    }
    if (_rulesKey != _key && !await _load()) return null;
    if (!mounted || !(_form.currentState?.validate() ?? false)) return null;
    return {
      for (final entry in _fields.entries) entry.key: entry.value.text.trim(),
      'state': _fields['state']!.text.trim().toUpperCase(),
      'city_ibge': _ibge,
      'locality_id': _requiresLocality ? _locality : 0
    };
  }

  @override
  void dispose() {
    _debounce?.cancel();
    ++_request;
    for (final field in _fields.values) {
      field.dispose();
    }
    super.dispose();
  }

  Widget _field(String key, String label,
          {bool required = true,
          int maxLength = 100,
          TextInputType keyboard = TextInputType.streetAddress}) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
              controller: _fields[key],
              enabled: widget.enabled && !_lookup,
              maxLength: maxLength,
              keyboardType: keyboard,
              textCapitalization: key == 'state'
                  ? TextCapitalization.characters
                  : TextCapitalization.words,
              inputFormatters: key == 'zip'
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : null,
              decoration: LDecoration(
                  labelText: label,
                  border: const OutlineInputBorder(),
                  counterText: ''),
              validator: (value) {
                final text = (value ?? '').trim();
                if (required && text.isEmpty)
                  return tr('Preencha ${tr(label)}.');
                if (key == 'zip' && !RegExp(r'^\d{8}$').hasMatch(text))
                  return tr('Informe os 8 dígitos do CEP.');
                if (key == 'state' &&
                    !const [
                      'AC',
                      'AL',
                      'AP',
                      'AM',
                      'BA',
                      'CE',
                      'DF',
                      'ES',
                      'GO',
                      'MA',
                      'MT',
                      'MS',
                      'MG',
                      'PA',
                      'PB',
                      'PR',
                      'PE',
                      'PI',
                      'RJ',
                      'RN',
                      'RS',
                      'RO',
                      'RR',
                      'SC',
                      'SP',
                      'SE',
                      'TO'
                    ].contains(text.toUpperCase()))
                  return tr('Informe uma UF válida.');
                return null;
              }));
  Widget _district() {
    if (!_requiresLocality) return _field('district', 'Bairro', maxLength: 50);
    final items = listValue(_rules['localities']);
    return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: DropdownButtonFormField<int>(
            key: ValueKey('${_rulesKey ?? _key}|$_locality'),
            value: _locality,
            isExpanded: true,
            decoration: const LDecoration(
                labelText: 'Bairro / Balneário / Distrito',
                border: OutlineInputBorder()),
            items: items
                .map((l) => DropdownMenuItem<int>(
                    value: int.parse(stringValue(l['id'])),
                    child: LText(stringValue(l['name']),
                        translate: false, overflow: TextOverflow.ellipsis)))
                .toList(),
            onChanged: !widget.enabled || _loading
                ? null
                : (id) => setState(() {
                      _locality = id;
                      if (id != null)
                        _fields['district']!.text = stringValue(
                            items.firstWhere((l) =>
                                int.parse(stringValue(l['id'])) == id)['name']);
                    }),
            validator: (id) => id == null
                ? tr('Selecione o Bairro / Balneário / Distrito.')
                : null));
  }

  @override
  Widget build(BuildContext context) => Form(
      key: _form,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        OutlinedButton.icon(
          onPressed: widget.enabled && !_geoChecking && !_loading ? _useCurrentLocation : null,
          icon: _geoChecking
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.my_location),
          label: const LText('Usar minha localização atual'),
        ),
        const SizedBox(height: 5),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: LText('Sugere rua e número aproximados. Você pode corrigir tudo antes de salvar.'),
        ),
        if (_geoMessage != null)
          Padding(padding: const EdgeInsets.only(bottom: 12), child: LText(_geoMessage!)),
        if (widget.showLabel)
          _field('label', 'Nome do endereço (Casa, Trabalho...)'),
        _field('zip', 'CEP', maxLength: 8, keyboard: TextInputType.number),
        Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
                onPressed: !widget.enabled || _loading
                    ? null
                    : () => _load(lookup: true),
                icon: _lookup
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.search),
                label: const LText('Consultar CEP'))),
        _field('street', 'Rua / Avenida'),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: _field('number', 'Número', maxLength: 10)),
          const SizedBox(width: 12),
          Expanded(child: _field('complement', 'Complemento', required: false))
        ]),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(flex: 3, child: _field('city', 'Cidade', maxLength: 50)),
          const SizedBox(width: 12),
          Expanded(
              child: _field('state', 'UF',
                  maxLength: 2, keyboard: TextInputType.text))
        ]),
        if (_loading) const LinearProgressIndicator(),
        if (_loading)
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: LText('Consultando localidades...')),
        _district(),
        if (stringValue(_rules['message']).isNotEmpty)
          Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LText(stringValue(_rules['message']))),
        if (_error != null)
          Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LText(_error!,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.error))),
        TextButton(
            onPressed: !widget.enabled || _loading ? null : () => _load(),
            child: const LText('Consultar localidades')),
      ]));
}
