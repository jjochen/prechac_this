// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/navigation/cubit/navigation_cubit.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/screens/home/home.dart';

import '../../../helpers/helpers.dart';

void main() {
  const attributionsButtonKey = Key('homePage_attributions_iconButton');

  late PatternsBloc patternsBloc;
  late NavigationCubit navigationCubit;

  setUp(() {
    registerFallbackValue(FakePatternsEvent());
    registerFallbackValue(PatternsInitial());
    registerFallbackValue(NavigationState());
    patternsBloc = MockPatternsBloc();
    navigationCubit = MockNavigationCubit();
  });

  group('HomePage', () {
    testWidgets('renders a HomeView', (tester) async {
      when(() => patternsBloc.state).thenReturn(
        PatternsInitial(),
      );
      when(() => navigationCubit.state).thenReturn(
        NavigationState(),
      );
      await tester.pumpApp(
        patternsBloc: patternsBloc,
        navigationCubit: navigationCubit,
        widget: HomePage(),
      );
      expect(find.byType(HomeView), findsOneWidget);
    });
  });

  group('HomeView', () {
    testWidgets('renders a ConstraintsForm', (tester) async {
      when(() => patternsBloc.state).thenReturn(
        PatternsInitial(),
      );
      when(() => navigationCubit.state).thenReturn(
        NavigationState(),
      );
      await tester.pumpApp(
        patternsBloc: patternsBloc,
        navigationCubit: navigationCubit,
        widget: HomeView(),
      );
      expect(find.byType(ConstraintsForm), findsOneWidget);
    });

    testWidgets(
        'calls navigateToAttributions when attributions button is tapped',
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
        widget: HomeView(),
      );

      await tester.tap(find.byKey(attributionsButtonKey));
      verify(() => navigationCubit.navigateToAttributions()).called(1);
    });
  });
}
