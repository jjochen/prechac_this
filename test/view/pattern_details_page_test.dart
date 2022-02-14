// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/pattern_details/view/view.dart';

import '../helpers/helpers.dart';

void main() {
  group('PatternDetailsPage', () {
    testWidgets('renders list of juggler details', (tester) async {
      await tester.pumpApp(
        child: PatternDetailsPage(pattern: mockPattern),
      );
      expect(
        find.byKey(Key('__juggler_details_item_0')),
        findsOneWidget,
      );
      expect(
        find.byKey(Key('__juggler_details_item_1')),
        findsOneWidget,
      );
    });
  });
}
