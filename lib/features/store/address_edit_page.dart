import '../../core/localization/localized_widgets.dart';
import 'package:flutter/material.dart';
import 'address_form.dart';
import 'store_models.dart';
import 'store_repository.dart';

class AddressEditPage extends StatefulWidget {
  const AddressEditPage(
      {super.key, required this.repository, this.address, this.onSaved});
  final StoreRepository repository;
  final Map<String, dynamic>? address;
  final ValueChanged<String>? onSaved;
  @override
  State<AddressEditPage> createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  final _form = GlobalKey<AddressFormState>();
  bool _saving = false;
  String? _error;
  Future<void> _save() async {
    if (_saving) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final data = await _form.currentState!.read();
      if (data == null || !mounted) return;
      final saved = await widget.repository
          .saveAddress({...data, 'id': widget.address?['id'] ?? 'new'});
      if (mounted) {
        widget.onSaved?.call(stringValue(saved['address_id']));
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) setState(() => _error = '$e');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
      canPop: !_saving,
      child: Scaffold(
          appBar: AppBar(
              title: LText(widget.address == null
                  ? 'Novo endereço'
                  : 'Editar endereço')),
          body: ListView(padding: const EdgeInsets.all(16), children: [
            AddressForm(
                key: _form,
                address: widget.address,
                enabled: !_saving,
                showLabel: widget.address?['id'] != 'principal',
                loadRules: (address, lookup) =>
                    widget.repository.addressRules(address, lookupZip: lookup)),
            if (_error != null)
              Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: LText(_error!,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error))),
            FilledButton.icon(
                onPressed: _saving ? null : _save,
                icon: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.save_outlined),
                label: const LText('Salvar endereço')),
          ])));
}
