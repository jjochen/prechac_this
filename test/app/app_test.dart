// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/app.dart';
import 'package:prechac_this/app/flow/app_flow.dart';
import 'package:prechac_this/screens/home/home.dart';

import '../helpers/helpers.dart';

void main() {
  group('App', () {
    late FlowController<AppFlowState> flowController;

    setUp(() {
      flowController = FakeFlowController<AppFlowState>(AppFlowState());
    });

    testWidgets('renders HomePage', (tester) async {
      await tester.pumpApp(
        flowController: flowController,
        child: App(),
      );
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
