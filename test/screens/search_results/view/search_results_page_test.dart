// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/flow/app_flow.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

import '../../../helpers/helpers.dart';

void main() {
  late PatternsBloc patternsBloc;
  late FlowController<AppFlowState> flowController;

  setUp(() {
    flowController = FakeFlowController<AppFlowState>(AppFlowState());
    patternsBloc = MockPatternsBloc();
  });

  group('SearchResultsPage', () {
    testWidgets('renders list of patterns', (tester) async {
      await tester.pumpApp(
        providers: [BlocProvider(create: (_) => patternsBloc)],
        flowController: flowController,
        child: SearchResultsPage(patterns: [mockPattern]),
      );
      expect(
        find.byKey(Key('__pattern_item_${mockPattern.id}')),
        findsOneWidget,
      );
    });

    testWidgets('adds pattern to flow state when pattern is tapped',
        (tester) async {
      await tester.pumpApp(
        providers: [BlocProvider(create: (_) => patternsBloc)],
        flowController: flowController,
        child: SearchResultsPage(patterns: [mockPattern]),
      );

      await tester.tap(find.byKey(Key('__pattern_item_${mockPattern.id}')));
      expect(flowController.state, AppFlowState(currentPattern: mockPattern));
    });
  });
}
