// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/navigation/cubit/navigation_cubit.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

import '../../../helpers/helpers.dart';

void main() {
  late PatternsBloc patternsBloc;
  late NavigationCubit navigationCubit;

  setUp(() {
    registerFallbackValue(FakePatternsEvent());
    registerFallbackValue(PatternsInitial());
    registerFallbackValue(NavigationState());
    patternsBloc = MockPatternsBloc();
    navigationCubit = MockNavigationCubit();
  });

  group('SearchResultsPage', () {
    testWidgets('renders list of patterns', (tester) async {
      await tester.pumpApp(
        widget: SearchResultsPage(patterns: [mockPattern]),
      );
      expect(
        find.byKey(Key('__pattern_item_${mockPattern.id}')),
        findsOneWidget,
      );
    });

    testWidgets('calls navigateToPatternDetailView when pattern is tapped',
        (tester) async {
      when(() => patternsBloc.state).thenReturn(
        PatternsInitial(),
      );
      when(() => navigationCubit.state).thenReturn(
        NavigationState(),
      );
      await tester.pumpApp(
        patternsBloc: patternsBloc,
        navigationCubit: navigationCubit,
        widget: SearchResultsPage(patterns: [mockPattern]),
      );

      await tester.tap(find.byKey(Key('__pattern_item_${mockPattern.id}')));
      verify(
        () => navigationCubit.navigateToPatternDetailView(mockPattern),
      ).called(1);
    });
  });
}
