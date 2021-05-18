import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/app.dart';
import 'package:prechac_this/screens/home/home.dart';

void main() {
  group('App', () {
    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
