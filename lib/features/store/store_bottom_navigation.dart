import 'package:flutter/material.dart';

import '../../core/localization/message_catalog.dart';

/// Barra de navegacao compacta para telas estreitas (ex.: iPhone 6s / SE).
///
/// O NavigationBar padrao do Material 3 deixa os rotulos quebrarem linha quando
/// seis destinos competem por pouca largura. Aqui cada destino usa 1/6 da
/// largura, apresenta um rotulo curto em telas estreitas e impede quebra.
/// A descricao completa permanece disponivel para VoiceOver e tooltip.
class StoreBottomNavigation extends StatelessWidget {
  const StoreBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.cartCount,
    required this.accountIcon,
    required this.selectedAccountIcon,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final int cartCount;
  final Widget accountIcon;
  final Widget selectedAccountIcon;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    // Use a largura real recebida pela barra, e nao o MediaQuery global.
    // O tamanho disponivel pode ser menor que o do aparelho (e nos testes
    // setSurfaceSize pode mudar as constraints sem alterar MediaQuery.size).
    return LayoutBuilder(
      builder: (context, constraints) =>
          _buildForWidth(context, constraints.maxWidth),
    );
  }

  Widget _buildForWidth(BuildContext context, double availableWidth) {
    final scheme = Theme.of(context).colorScheme;
    final language = Localizations.localeOf(context).languageCode;
    final textScale = MediaQuery.textScalerOf(context).scale(12);
    final compact = availableWidth < 430 || textScale > 15;

    final entries = <_StoreNavEntry>[
      const _StoreNavEntry(
        'Ofertas',
        Icons.local_offer_outlined,
        Icons.local_offer,
        ['Ofertas', 'Offers', 'Ofertas'],
      ),
      const _StoreNavEntry(
        'Categorias',
        Icons.grid_view_outlined,
        Icons.grid_view_rounded,
        ['Cat.', 'Cats.', 'Cat.'],
      ),
      const _StoreNavEntry(
        'Loja',
        Icons.storefront_outlined,
        Icons.storefront_rounded,
        ['Loja', 'Store', 'Tienda'],
      ),
      const _StoreNavEntry(
        'Favoritos',
        Icons.favorite_border,
        Icons.favorite,
        ['Fav.', 'Fav.', 'Fav.'],
      ),
      const _StoreNavEntry(
        'Carrinho',
        Icons.shopping_cart_outlined,
        Icons.shopping_cart,
        ['Carr.', 'Cart', 'Carrito'],
      ),
      const _StoreNavEntry(
        'Conta',
        Icons.person_outline,
        Icons.person,
        ['Conta', 'Account', 'Cuenta'],
      ),
    ];

    return Material(
      elevation: 5,
      color: scheme.surface,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: scheme.outlineVariant, width: .6)),
        ),
        child: SafeArea(
          top: false,
          minimum: const EdgeInsets.only(bottom: 2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: SizedBox(
              height: compact ? 62 : 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var i = 0; i < entries.length; i++)
                    Expanded(
                      child: _StoreNavigationButton(
                        key: ValueKey('store-bottom-nav-$i'),
                        index: i,
                        entry: entries[i],
                        language: language,
                        compact: compact,
                        active: selectedIndex == i,
                        cartCount: cartCount,
                        accountIcon: accountIcon,
                        selectedAccountIcon: selectedAccountIcon,
                        onTap: () => onDestinationSelected(i),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StoreNavEntry {
  const _StoreNavEntry(this.name, this.icon, this.selectedIcon, this.compactLabels);
  final String name;
  final IconData icon;
  final IconData selectedIcon;
  // Ordem: portugues, ingles, espanhol.
  final List<String> compactLabels;

  String fullLabel(String language) => MessageCatalog.translate(name, language);

  String label(String language, bool compact) {
    if (!compact) return fullLabel(language);
    final index = language == 'en' ? 1 : language == 'es' ? 2 : 0;
    return compactLabels[index];
  }
}

class _StoreNavigationButton extends StatelessWidget {
  const _StoreNavigationButton({
    super.key,
    required this.index,
    required this.entry,
    required this.language,
    required this.compact,
    required this.active,
    required this.cartCount,
    required this.accountIcon,
    required this.selectedAccountIcon,
    required this.onTap,
  });

  final int index;
  final _StoreNavEntry entry;
  final String language;
  final bool compact;
  final bool active;
  final int cartCount;
  final Widget accountIcon;
  final Widget selectedAccountIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isStore = index == 2;
    final iconColor = active ? scheme.primary : scheme.onSurfaceVariant;
    final textColor = active ? scheme.primary : scheme.onSurfaceVariant;
    final fullLabel = entry.fullLabel(language);

    Widget icon;
    if (index == 5) {
      icon = active ? selectedAccountIcon : accountIcon;
    } else {
      icon = Icon(
        active ? entry.selectedIcon : entry.icon,
        size: isStore ? (active ? 32 : 28) : 24,
      );
    }
    if (index == 4 && cartCount > 0) {
      icon = Badge(
        label: Text(cartCount > 99 ? '99+' : '$cartCount'),
        child: icon,
      );
    }

    return Semantics(
      button: true,
      selected: active,
      label: fullLabel,
      child: ExcludeSemantics(
        child: Tooltip(
          message: fullLabel,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: isStore ? 48 : 42,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: active
                          ? (isStore ? scheme.primaryContainer : scheme.secondaryContainer)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: IconTheme(
                      data: IconThemeData(color: iconColor),
                      child: icon,
                    ),
                  ),
                  const SizedBox(height: 2),
                  SizedBox(
                    height: compact ? 15 : 18,
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: Text(
                        entry.label(language, compact),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: compact ? 11 : 12,
                          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
