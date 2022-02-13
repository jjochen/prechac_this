// ignore_for_file: prefer_const_constructors

import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/flow/app_flow.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/screens/attributions/view/attributions_page.dart';
import 'package:prechac_this/screens/home/home.dart';
import 'package:prechac_this/screens/pattern_details/view/view.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

import '../../helpers/helpers.dart';

void main() {
  group('AppFlow', () {
    late AppFlow appFlow;
    late MockConstraintsFormBloc constraintsFormBloc;
    late PatternsBloc patternsBloc;
    late TestApp testApp;

    setUp(() {
      constraintsFormBloc = MockConstraintsFormBloc();
      patternsBloc = MockPatternsBloc();
      appFlow = AppFlow();
      testApp = TestApp(
        providers: [
          BlocProvider<PatternsBloc>(create: (_) => patternsBloc),
          BlocProvider<ConstraintsFormBloc>(create: (_) => constraintsFormBloc),
        ],
        child: Scaffold(
          body: appFlow,
        ),
      );
    });

    testWidgets('shows HomePage as default', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('shows AttributionsPage when showAttributions is true',
        (tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();
      final BuildContext context = tester.element(find.byType(HomePage));
      context.flow<AppFlowState>().update(
            (flowState) => flowState.copyWith(
              showAttributions: true,
            ),
          );
      await tester.pumpAndSettle();
      expect(find.byType(AttributionsPage), findsOneWidget);
    });

    testWidgets('shows PatternDetailsPage when currentPattern is set',
        (tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();
      final BuildContext context = tester.element(find.byType(HomePage));
      context.flow<AppFlowState>().update(
            (flowState) => flowState.copyWith(
              currentPattern: mockPattern,
            ),
          );
      await tester.pumpAndSettle();
      expect(find.byType(PatternDetailsPage), findsOneWidget);
    });

    testWidgets('shows SearchResultsPage when currentPattern is set',
        (tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();
      final BuildContext context = tester.element(find.byType(HomePage));
      context.flow<AppFlowState>().update(
            (flowState) => flowState.copyWith(
              listOfPatterns: [mockPattern],
            ),
          );
      await tester.pumpAndSettle();
      expect(find.byType(SearchResultsPage), findsOneWidget);
    });
  });
}
