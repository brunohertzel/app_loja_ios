import '../../core/localization/localized_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../store/address_form.dart';
import '../store/store_models.dart';

import '../../core/models/bootstrap_config.dart';
import '../../core/network/api_client.dart';
import 'auth_repository.dart';
import '../store/customer_care_pages.dart';
import '../store/store_repository.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    required this.auth,
    required this.bootstrap,
    this.googleIdToken,
    this.prefillName,
    this.prefillEmail,
  });

  final AuthRepository auth;
  final AppBootstrap bootstrap;
  final String? googleIdToken;
  final String? prefillName;
  final String? prefillEmail;

  bool get isGoogle => googleIdToken != null && googleIdToken!.isNotEmpty;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _name;
  final _document = TextEditingController();
  late final TextEditingController _email;
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _password2 = TextEditingController();
  final _addressForm = GlobalKey<AddressFormState>();
  final _fantasy = TextEditingController();
  final _stateRegistration = TextEditingController();
  String _accountType = 'CPF';
  bool _accept = false;
  List<Map<String, dynamic>>? _legalDocuments;
  bool _loading = false;
  bool _obscure = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.prefillName ?? '');
    _email = TextEditingController(text: widget.prefillEmail ?? '');
  }

  @override
  void dispose() {
    for (final c in [
      _name,
      _document,
      _email,
      _phone,
      _fantasy,
      _stateRegistration,
      _password,
      _password2,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    final doc = _document.text.replaceAll(RegExp(r'\D'), '');
    if (_name.text.trim().length < 3 ||
        doc.length != (_accountType == 'CPF' ? 11 : 14) ||
        _email.text.trim().isEmpty) {
      setState(() => _error = 'Informe nome, CPF/CNPJ e e-mail corretamente.');
      return;
    }
    if (!widget.isGoogle) {
      if (_password.text.length < 6) {
        setState(() => _error = 'A senha precisa ter pelo menos 6 caracteres.');
        return;
      }
      if (_password.text != _password2.text) {
        setState(() => _error = 'As senhas não conferem.');
        return;
      }
    }
    if (!_accept) {
      setState(
        () => _error =
            'É necessário aceitar os termos e a política de privacidade.',
      );
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final address = await _addressForm.currentState!.read();
      if (address == null || !mounted) return;
      Map<String, dynamic> result;
      if (widget.isGoogle) {
        result = await widget.auth.googleLogin(
          idToken: widget.googleIdToken!,
          rememberMe: true,
          legalDocuments: _legalDocuments,
          registration: <String, dynamic>{
            'name': _name.text.trim(),
            'document': doc,
            'phone': _phone.text.trim(),
            'fantasy_name': _fantasy.text.trim(),
            'state_registration': _stateRegistration.text.trim(),
            ...address,
          },
        );
      } else {
        result = await widget.auth.register(
          name: _name.text.trim(),
          document: doc,
          email: _email.text.trim(),
          phone: _phone.text.trim(),
          password: _password.text,
          rememberMe: true,
          address: address,
          fantasyName: _fantasy.text.trim(),
          stateRegistration: _stateRegistration.text.trim(),
          legalDocuments: _legalDocuments,
        );
      }
      if (!mounted) return;
      if (boolValue(result['approval_required'])) {
        await showDialog<void>(
            context: context,
            builder: (dialogContext) => AlertDialog(
                    title: const LText('Cadastro recebido'),
                    content: LText(stringValue(result['message'])),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: const LText('OK'))
                    ]));
        if (mounted) Navigator.of(context).pop(false);
      } else {
        Navigator.of(context).pop(true);
      }
    } on ApiException catch (e) {
      if (mounted)
        setState(() {
          _error = e.message;
          if (e.code == 'LEGAL_DOCUMENTS_CHANGED') {
            _accept = false;
            _legalDocuments = null;
          }
        });
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LText(
          widget.isGoogle ? 'Completar cadastro Google' : 'Criar conta',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          if (widget.isGoogle)
            const Padding(
              padding: EdgeInsets.only(bottom: 14),
              child: LText(
                'Sua conta Google foi validada. Complete os dados necessários para entrega e faturamento.',
              ),
            ),
          DropdownButtonFormField<String>(
              value: _accountType,
              decoration: const LDecoration(labelText: 'Tipo de conta'),
              items: const [
                DropdownMenuItem(value: 'CPF', child: LText('CPF')),
                DropdownMenuItem(value: 'CNPJ', child: LText('CNPJ'))
              ],
              onChanged: _loading
                  ? null
                  : (value) => setState(() => _accountType = value!)),
          const SizedBox(height: 10),
          _field(
              _name,
              _accountType == 'CPF' ? 'Nome completo' : 'Razão social',
              Icons.person_outline),
          _field(
            _document,
            _accountType,
            Icons.badge_outlined,
            keyboard: TextInputType.number,
          ),
          _field(
            _email,
            'E-mail',
            Icons.email_outlined,
            keyboard: TextInputType.emailAddress,
            enabled: !widget.isGoogle,
          ),
          _field(
            _phone,
            'Celular',
            Icons.phone_outlined,
            keyboard: TextInputType.phone,
          ),
          if (_accountType == 'CNPJ') ...[
            _field(_fantasy, 'Nome fantasia (opcional)', Icons.store_outlined),
            _field(_stateRegistration, 'Inscrição estadual (opcional)',
                Icons.badge_outlined),
            const LText('Contas CNPJ precisam de aprovação comercial da loja.'),
          ],
          const SizedBox(height: 10),
          LText(
            'Endereço principal',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          AddressForm(
              key: _addressForm,
              enabled: !_loading,
              ruleContext: _accountType,
              loadRules: (address, lookup) => widget.auth.addressRules(address,
                  lookupZip: lookup, accountType: _accountType)),
          if (!widget.isGoogle) ...[
            const SizedBox(height: 10),
            TextField(
              controller: _password,
              obscureText: _obscure,
              decoration: LDecoration(
                labelText: 'Senha',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  icon: Icon(
                    _obscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _password2,
              obscureText: _obscure,
              decoration: const LDecoration(
                labelText: 'Confirmar senha',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
          ],
          const SizedBox(height: 8),
          CheckboxListTile(
            value: _accept,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: const LText(
              'Ler e aceitar os termos de uso e a política de privacidade.',
            ),
            onChanged: _loading
                ? null
                : (v) async {
                    if (v != true) {
                      setState(() => _accept = false);
                      return;
                    }
                    if (!widget.bootstrap.customerCareEnabled) {
                      setState(() => _accept = true);
                      return;
                    }
                    final docs = await Navigator.of(context)
                        .push<List<Map<String, dynamic>>>(
                      MaterialPageRoute(
                        builder: (_) => LegalDocumentsPage(
                          repository: StoreRepository(
                            widget.auth.api,
                            auth: widget.auth,
                          ),
                          registration: true,
                        ),
                      ),
                    );
                    if (mounted && docs != null)
                      setState(() {
                        _legalDocuments = docs;
                        _accept = true;
                      });
                  },
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            LText(
              _error!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: _loading ? null : _submit,
            icon: _loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.person_add_alt_1),
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: LText(
                widget.isGoogle ? 'CONCLUIR CADASTRO' : 'CRIAR MINHA CONTA',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType? keyboard,
    bool enabled = true,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextField(
          controller: controller,
          enabled: enabled && !_loading,
          inputFormatters: controller == _document
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          keyboardType: keyboard,
          decoration: LDecoration(labelText: label, prefixIcon: Icon(icon)),
        ),
      );
}
