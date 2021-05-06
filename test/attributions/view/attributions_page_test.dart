import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:prechac_this/attributions/attributions.dart';

void main() {
  group('AttributionsPage', () {
    test('has a route', () {
      expect(AttributionsPage.route(), isA<MaterialPageRoute>());
    });
    testWidgets('renders icon', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AttributionsPage()));
      expect(find.byKey(const Key('application_icon_image')), findsOneWidget);
    });
  });
}
