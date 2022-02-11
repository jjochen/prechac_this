// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/flow/app_flow.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/screens/home/home.dart';

import '../../../helpers/helpers.dart';

void main() {
  const attributionsButtonKey = Key('homePage_attributions_iconButton');

  late PatternsBloc patternsBloc;
  late FlowController<AppFlowState> flowController;

  setUp(() {
    flowController = FakeFlowController<AppFlowState>(AppFlowState());
    patternsBloc = MockPatternsBloc();
  });

  group('HomePage', () {
    testWidgets('renders a HomeView', (tester) async {
      await tester.pumpApp(
        providers: [BlocProvider(create: (_) => patternsBloc)],
        flowController: flowController,
        child: HomePage(),
      );
      expect(find.byType(HomeView), findsOneWidget);
    });
  });

  group('HomeView', () {
    testWidgets('renders a ConstraintsForm', (tester) async {
      await tester.pumpApp(
        providers: [BlocProvider(create: (_) => patternsBloc)],
        flowController: flowController,
        child: HomeView(),
      );
      expect(find.byType(ConstraintsForm), findsOneWidget);
    });

    testWidgets(
        'calls navigateToAttributions when attributions button is tapped',
        (tester) async {
      await tester.pumpApp(
        providers: [BlocProvider(create: (_) => patternsBloc)],
        flowController: flowController,
        child: HomeView(),
      );
      await tester.tap(find.byKey(attributionsButtonKey));
      expect(flowController.state, AppFlowState(showAttributions: true));
    });
  });
}
