// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/flow/app_flow.dart';
import 'package:prechac_this/home/home.dart';

import '../../helpers/helpers.dart';

void main() {
  const attributionsButtonKey = Key('homePage_attributions_iconButton');

  late FlowController<AppFlowState> flowController;
  late TestApp testApp;

  setUp(() {
    flowController = FakeFlowController<AppFlowState>(AppFlowState());

    testApp = TestApp(
      flowController: flowController,
      child: HomePage(),
    );
  });

  group('HomePage', () {
    testWidgets('renders a ConstraintsForm', (tester) async {
      await tester.pumpWidget(testApp);
      expect(find.byType(ConstraintsForm), findsOneWidget);
    });

    testWidgets(
        'calls navigateToAttributions when attributions button is tapped',
        (tester) async {
      await tester.pumpWidget(testApp);
      await tester.tap(find.byKey(attributionsButtonKey));
      expect(flowController.state, AppFlowState(showAttributions: true));
    });
  });
}
