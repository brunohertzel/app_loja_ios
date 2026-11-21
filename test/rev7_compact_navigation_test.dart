import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:soft_ecommerce_mobile/features/store/store_bottom_navigation.dart';

Widget _testApp({
  Locale locale = const Locale('pt', 'BR'),
  int selectedIndex = 2,
  int cartCount = 2,
  ValueChanged<int>? onDestinationSelected,
}) {
  return MaterialApp(
    locale: locale,
    supportedLocales: const [Locale('pt', 'BR'), Locale('en'), Locale('es')],
    // Mesmos delegates do app real. Sem eles, flutter_test emite um warning
    // para pt_BR e os testes falham mesmo sem nenhum overflow na barra.
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: Scaffold(
      body: const Center(child: Text('Home')),
      bottomNavigationBar: StoreBottomNavigation(
        selectedIndex: selectedIndex,
        cartCount: cartCount,
        accountIcon: const Icon(Icons.person_outline),
        selectedAccountIcon: const Icon(Icons.person),
        onDestinationSelected: onDestinationSelected ?? (_) {},
      ),
    ),
  );
}

void main() {
  for (final width in [320.0, 375.0, 390.0, 430.0]) {
    testWidgets('barra sem overflow em ${width.toInt()}px, com seis destinos',
        (tester) async {
      await tester.binding.setSurfaceSize(Size(width, 667));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_testApp());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      for (var index = 0; index < 6; index++) {
        expect(find.byKey(ValueKey('store-bottom-nav-$index')),
            findsOneWidget);
      }
      expect(find.text('Loja'), findsOneWidget);
      if (width < 430) {
        expect(find.text('Cat.'), findsOneWidget);
        expect(find.text('Fav.'), findsOneWidget);
        expect(find.text('Carr.'), findsOneWidget);
      } else {
        expect(find.text('Categorias'), findsOneWidget);
        expect(find.text('Favoritos'), findsOneWidget);
        expect(find.text('Carrinho'), findsOneWidget);
      }
    });
  }

  testWidgets('os seis destinos continuam clicaveis', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 667));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final tapped = <int>[];
    await tester.pumpWidget(_testApp(onDestinationSelected: tapped.add));
    for (var index = 0; index < 6; index++) {
      await tester.tap(find.byKey(ValueKey('store-bottom-nav-$index')));
    }
    expect(tapped, [0, 1, 2, 3, 4, 5]);
    expect(tester.takeException(), isNull);
  });

  testWidgets('ingles e espanhol mantem etiquetas curtas', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 667));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_testApp(locale: const Locale('en')));
    await tester.pumpAndSettle();
    expect(find.text('Cats.'), findsOneWidget);
    expect(find.text('Cart'), findsOneWidget);
    await tester.pumpWidget(_testApp(locale: const Locale('es')));
    await tester.pumpAndSettle();
    expect(find.text('Cat.'), findsOneWidget);
    expect(find.text('Carrito'), findsOneWidget);
    expect(find.text('Tienda'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('contador permanece visivel e respeita area segura',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(375, 667));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_testApp(cartCount: 12));
    await tester.pumpAndSettle();
    expect(find.text('12'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
