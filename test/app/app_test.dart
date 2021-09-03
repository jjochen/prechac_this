// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/app/app.dart';
import 'package:prechac_this/navigation/cubit/navigation_cubit.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/screens/home/home.dart';

import '../helpers/helpers.dart';

void main() {
  group('App', () {
    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    late PatternsBloc patternsBloc;
    late NavigationCubit navigationCubit;

    setUp(() {
      registerFallbackValue(FakePatternsEvent());
      registerFallbackValue(PatternsInitial());
      registerFallbackValue(NavigationState());
      patternsBloc = MockPatternsBloc();
      navigationCubit = MockNavigationCubit();
    });

    testWidgets('renders HomePage', (tester) async {
      when(() => patternsBloc.state).thenReturn(
        PatternsInitial(),
      );
      when(() => navigationCubit.state).thenReturn(
        NavigationState(),
      );
      await tester.pumpApp(
        patternsBloc: patternsBloc,
        navigationCubit: navigationCubit,
        widget: AppView(),
      );
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
