import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/screens/home/home.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

import '../../../helpers/helpers.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

class MockNumberOfJugglers extends Mock implements NumberOfJugglers {}

class MockPeriod extends Mock implements Period {}

class MockNumberOfObjects extends Mock implements NumberOfObjects {}

class MockMaxHeight extends Mock implements MaxHeight {}

void main() {
  const submitButtonKey = Key('constraintsForm_submit_raisedButton');
  const numberOfJugglersInputKey = Key('constraintsForm_numberOfJugglersInput');
  const periodInputKey = Key('constraintsForm_periodInput');
  const numberOfObjectsInputKey = Key('constraintsForm_numberOfObjectsInput');
  const maxHeightInputKey = Key('constraintsForm_maxHeightInput');

  const testNumberOfJugglers = 5;
  const testPeriod = 6;
  const testNumberOfObjects = 7;
  const testMaxHeight = 8;

  group('ConstraintsForm', () {
    registerFallbackValue<HomeState>(const HomeState());

    late HomeCubit homeCubit;

    setUp(() {
      homeCubit = MockHomeCubit();
      when(() => homeCubit.state).thenReturn(const HomeState());
    });

    group('calls', () {
      testWidgets('numberOfJugglersChanged when number of jugglers changes',
          (tester) async {
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: homeCubit,
              child: ConstraintsForm(),
            ),
          ),
        );
        await tester.enterText(find.byKey(numberOfJugglersInputKey),
            testNumberOfJugglers.toString());
        verify(() => homeCubit.numberOfJugglersChanged(testNumberOfJugglers))
            .called(1);
      });

      testWidgets('periodChanged when period changes', (tester) async {
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: homeCubit,
              child: ConstraintsForm(),
            ),
          ),
        );
        await tester.enterText(
            find.byKey(periodInputKey), testPeriod.toString());
        verify(() => homeCubit.periodChanged(testPeriod)).called(1);
      });

      testWidgets(
          'numberOfObjectsChanged '
          'when number of objects changes', (tester) async {
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: homeCubit,
              child: ConstraintsForm(),
            ),
          ),
        );
        await tester.enterText(find.byKey(numberOfObjectsInputKey),
            testNumberOfObjects.toString());
        verify(() => homeCubit.numberOfObjectsChanged(testNumberOfObjects))
            .called(1);
      });

      testWidgets('maxHeightChanged when max height changes', (tester) async {
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: homeCubit,
              child: ConstraintsForm(),
            ),
          ),
        );
        await tester.enterText(
            find.byKey(maxHeightInputKey), testMaxHeight.toString());
        verify(() => homeCubit.maxHeightChanged(testMaxHeight)).called(1);
      });

      testWidgets('submit when submit button is pressed', (tester) async {
        when(() => homeCubit.state).thenReturn(
          const HomeState(status: FormzStatus.valid),
        );
        when(() => homeCubit.submit()).thenAnswer((_) async => null);
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: homeCubit,
              child: ConstraintsForm(),
            ),
          ),
        );
        await tester.tap(find.byKey(submitButtonKey));
        verify(() => homeCubit.submit()).called(1);
      });
    });

    group('renders', () {
      testWidgets('Failure SnackBar when submission fails', (tester) async {
        whenListen(
          homeCubit,
          Stream.fromIterable(const <HomeState>[
            HomeState(status: FormzStatus.submissionInProgress),
            HomeState(status: FormzStatus.submissionFailure),
          ]),
        );
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: homeCubit,
              child: ConstraintsForm(),
            ),
          ),
        );
        await tester.pump();
        expect(find.text('Failure'), findsOneWidget);
      });

      testWidgets(
          'invalid number of jugglers error text '
          'when number of jugglers is invalid', (tester) async {
        final numberOfJugglers = MockNumberOfJugglers();
        when(() => numberOfJugglers.invalid).thenReturn(true);
        when(() => homeCubit.state)
            .thenReturn(HomeState(numberOfJugglers: numberOfJugglers));
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: homeCubit,
              child: ConstraintsForm(),
            ),
          ),
        );
        expect(find.text('invalid number of jugglers'), findsOneWidget);
      });

      testWidgets('invalid period error text when period is invalid',
          (tester) async {
        final period = MockPeriod();
        when(() => period.invalid).thenReturn(true);
        when(() => homeCubit.state).thenReturn(HomeState(period: period));
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: homeCubit,
              child: ConstraintsForm(),
            ),
          ),
        );
        expect(find.text('invalid period'), findsOneWidget);
      });

      testWidgets(
          'invalid number of objects error text '
          'when number of objects is invalid', (tester) async {
        final numberOfObjects = MockNumberOfObjects();
        when(() => numberOfObjects.invalid).thenReturn(true);
        when(() => homeCubit.state)
            .thenReturn(HomeState(numberOfObjects: numberOfObjects));
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: homeCubit,
              child: ConstraintsForm(),
            ),
          ),
        );
        expect(find.text('invalid number of objects'), findsOneWidget);
      });

      testWidgets('invalid max height error text when max height is invalid',
          (tester) async {
        final maxHeight = MockMaxHeight();
        when(() => maxHeight.invalid).thenReturn(true);
        when(() => homeCubit.state).thenReturn(HomeState(maxHeight: maxHeight));
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: homeCubit,
              child: ConstraintsForm(),
            ),
          ),
        );
        expect(find.text('invalid max height'), findsOneWidget);
      });

      testWidgets('disabled submit button when status is not validated',
          (tester) async {
        when(() => homeCubit.state).thenReturn(
          const HomeState(status: FormzStatus.invalid),
        );
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: homeCubit,
              child: ConstraintsForm(),
            ),
          ),
        );
        final homeButton = tester.widget<ElevatedButton>(
          find.byKey(submitButtonKey),
        );
        expect(homeButton.enabled, isFalse);
      });

      testWidgets('enabled submit button when status is validated',
          (tester) async {
        when(() => homeCubit.state).thenReturn(
          const HomeState(status: FormzStatus.valid),
        );
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: homeCubit,
              child: ConstraintsForm(),
            ),
          ),
        );
        final submitButton = tester.widget<ElevatedButton>(
          find.byKey(submitButtonKey),
        );
        expect(submitButton.enabled, isTrue);
      });
    });

    group('navigates', () {
      testWidgets('to search results page when form status is success',
          (tester) async {
        whenListen(
          homeCubit,
          Stream.fromIterable(const <HomeState>[
            HomeState(status: FormzStatus.submissionInProgress),
            HomeState(status: FormzStatus.submissionSuccess),
          ]),
        );
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: homeCubit,
              child: ConstraintsForm(),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(SearchResultsPage), findsOneWidget);
      });
    });
  });
}
