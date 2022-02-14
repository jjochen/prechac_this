// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/attributions/attributions.dart';

import '../../helpers/helpers.dart';

void main() {
  group('AttributionsPage', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpApp(child: AttributionsPage());
      expect(find.text('PrechacThis'), findsOneWidget);
    });
  });
}
