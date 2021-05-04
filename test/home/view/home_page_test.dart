import 'package:flutter/material.dart';
import 'package:prechac_this/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
  });
}
