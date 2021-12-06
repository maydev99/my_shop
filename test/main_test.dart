import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:layout/ui/main.dart';
import 'package:layout/utils/providers.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';


class MockNavigatorObserver extends Mock implements NavigatorObserver {}

final mockObserver = MockNavigatorObserver();

Widget createMainScreen() => ChangeNotifierProvider<CartItemCounter>(
  create: (context) => CartItemCounter(),
  child: MaterialApp(
    home: const MyHomePage(),
    navigatorObservers: [mockObserver],

  ),
);

void main() {
  group('Home Page Widget Tests', () {
    testWidgets('Check Title is correct', (WidgetTester tester) async {
      await tester.pumpWidget(createMainScreen());
      expect(find.text('shoppe michael'), findsOneWidget);
    });

    testWidgets('Check if -select category- is visible', (WidgetTester tester) async{
      await tester.pumpWidget(createMainScreen());
      expect(find.text('Select a Category'), findsOneWidget);
    });

    testWidgets('Check if badge is visible', (WidgetTester tester) async{
      await tester.pumpWidget(createMainScreen());
      expect(find.byKey(const Key('main_badge_key')), findsOneWidget);

    });

    testWidgets('Check category buttons are visible', (WidgetTester tester) async{
      await tester.pumpWidget(createMainScreen());
      expect(find.text('Electronics'), findsOneWidget);
      expect(find.text('Jewelery'), findsOneWidget);
      expect(find.text("Men's Clothing"), findsOneWidget);
      expect(find.text("Women's Clothing"), findsOneWidget);

    });

  });
}

