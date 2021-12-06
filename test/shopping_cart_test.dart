import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout/ui/main.dart';
import 'package:layout/ui/shopping_cart.dart';
import 'package:layout/utils/providers.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';

Widget createShoppingCartScreen() => ChangeNotifierProvider<CartItemCounter>(
  create: (context) => CartItemCounter(),
  child: const MaterialApp(
    home: ShoppingCartPage(),

  ),
);

void main() {
  group('Shopping Cart Tests', () {

    testWidgets('Find Shopping Cart Summary', (WidgetTester tester) async {
      await tester.pumpWidget(createShoppingCartScreen());
      expect(find.text('Shopping Cart Summary'), findsOneWidget);
      expect(find.byType(MaterialButton), findsOneWidget);
    });

    testWidgets('Check out an read toast', (WidgetTester tester) async {
      await tester.pumpWidget(createShoppingCartScreen());
      await tester.tap(find.byType(MaterialButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Thank you for Shopping'), findsOneWidget);
    });

  });
}

