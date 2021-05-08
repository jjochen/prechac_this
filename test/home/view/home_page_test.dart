import 'package:flutter/material.dart';
import 'package:prechac_this/app/app_router.dart';
import 'package:prechac_this/attributions/attributions.dart';
import 'package:prechac_this/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const attributionsButtonKey = Key('homePage_attributions_iconButton');

  group('HomePage', () {
    test('has a route', () {
      expect(HomePage.route(), isA<MaterialPageRoute>());
    });

    testWidgets('renders a ConstraintsForm', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: HomePage()),
      );
      expect(find.byType(ConstraintsForm), findsOneWidget);
    });

    group('navigates', () {
      testWidgets('to Attributions when attributions icon is pressed',
          (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            initialRoute: 'search',
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(attributionsButtonKey));
        await tester.pumpAndSettle();
        expect(find.byType(AttributionsPage), findsOneWidget);
      });
    });
  });
}
