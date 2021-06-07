// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/screens/search_results/widgets/loading_indicator.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('LoadingIndicator', () {
    testWidgets('renders SearchResultsView', (tester) async {
      await tester.pumpApp(widget: LoadingIndicator());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
