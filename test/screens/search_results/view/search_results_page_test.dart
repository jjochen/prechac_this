import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('SearchResultsPage', () {
    testWidgets('renders list of patterns', (tester) async {
      await tester.pumpApp(
        widget: SearchResultsPage(
          patterns: [mockPattern],
        ),
      );
      expect(find.byKey(Key('__pattern_item_$mockPattern')), findsOneWidget);
    });
  });
}
