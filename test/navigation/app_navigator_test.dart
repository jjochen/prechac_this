// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/navigation/app_navigator.dart';
import 'package:prechac_this/navigation/cubit/navigation_cubit.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/screens/attributions/attributions.dart';
import 'package:prechac_this/screens/home/home.dart';
import 'package:prechac_this/screens/pattern_details/pattern_details.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

import '../helpers/helpers.dart';

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

  group('navigates to', () {
    testWidgets('attributions', (tester) async {
      final state = NavigationState(showAttributions: true);
      whenListen(
        navigationCubit,
        Stream.fromIterable(<NavigationState>[
          NavigationState(),
          state,
        ]),
      );
      when(() => navigationCubit.state).thenReturn(
        state,
      );

      await tester.pumpApp(
        patternsBloc: patternsBloc,
        navigationCubit: navigationCubit,
        widget: AppNavigator(),
      );
      await tester.pumpAndSettle();
      expect(find.byType(AttributionsPage), findsOneWidget);
    });

    testWidgets('list of patterns', (tester) async {
      final state = NavigationState(listOfPatterns: [mockPattern]);
      whenListen(
        navigationCubit,
        Stream.fromIterable(<NavigationState>[
          NavigationState(),
          state,
        ]),
      );
      when(() => navigationCubit.state).thenReturn(
        state,
      );

      await tester.pumpApp(
        patternsBloc: patternsBloc,
        navigationCubit: navigationCubit,
        widget: AppNavigator(),
      );
      await tester.pumpAndSettle();
      expect(find.byType(SearchResultsPage), findsOneWidget);
    });

    testWidgets('pattern details', (tester) async {
      final state = NavigationState(currentPattern: mockPattern);
      whenListen(
        navigationCubit,
        Stream.fromIterable(<NavigationState>[
          NavigationState(),
          state,
        ]),
      );
      when(() => navigationCubit.state).thenReturn(
        state,
      );

      await tester.pumpApp(
        patternsBloc: patternsBloc,
        navigationCubit: navigationCubit,
        widget: AppNavigator(),
      );
      await tester.pumpAndSettle();
      expect(find.byType(PatternDetailsPage), findsOneWidget);
    });
  });

  testWidgets('navigates back and calls pop()', (tester) async {
    final state = NavigationState(showAttributions: true);
    whenListen(
      navigationCubit,
      Stream.fromIterable(<NavigationState>[
        NavigationState(),
        state,
      ]),
    );
    when(() => navigationCubit.state).thenReturn(
      state,
    );

    await tester.pumpApp(
      patternsBloc: patternsBloc,
      navigationCubit: navigationCubit,
      widget: AppNavigator(),
    );
    await tester.pumpAndSettle();
    var backButton = find.byTooltip('Back');
    if (backButton.evaluate().isEmpty) {
      backButton = find.byType(CupertinoNavigationBarBackButton);
    }
    expectSync(backButton, findsOneWidget);

    expect(find.byType(ConstraintsForm), findsNothing);
    await tester.tap(backButton);
    await tester.pumpAndSettle();
    expect(find.byType(ConstraintsForm), findsOneWidget);
    verify(() => navigationCubit.pop()).called(1);
  });
}
