// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/screens/attributions/attributions.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('AttributionsPage', () {
    testWidgets('renders icon', (tester) async {
      await tester.pumpApp(widget: AttributionsPage());
      expect(find.byKey(const Key('application_icon_image')), findsOneWidget);
    });
  });
}
