// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/screens/home/home.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

import '../../../helpers/helpers.dart';

class MockConstraintsFormBloc extends MockCubit<ConstraintsFormState>
    implements ConstraintsFormBloc {}

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
    registerFallbackValue<ConstraintsFormState>(const ConstraintsFormState());

    late ConstraintsFormBloc constraintsFormBloc;

    setUp(() {
      constraintsFormBloc = MockConstraintsFormBloc();
      when(() => constraintsFormBloc.state)
          .thenReturn(const ConstraintsFormState());
    });

    group('calls', () {
      testWidgets('numberOfJugglersChanged when number of jugglers changes',
          (tester) async {
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
              child: ConstraintsForm(),
            ),
          ),
        );
        await tester.enterText(find.byKey(numberOfJugglersInputKey),
            testNumberOfJugglers.toString());
        verify(() => constraintsFormBloc.add(
              NumberOfJugglersDidChange(testNumberOfJugglers),
            )).called(1);
      });

      testWidgets('periodChanged when period changes', (tester) async {
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
              child: ConstraintsForm(),
            ),
          ),
        );
        await tester.enterText(
            find.byKey(periodInputKey), testPeriod.toString());
        verify(() => constraintsFormBloc.add(
              PeriodDidChange(testNumberOfJugglers),
            )).called(1);
      });

      testWidgets(
          'numberOfObjectsChanged '
          'when number of objects changes', (tester) async {
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
              child: ConstraintsForm(),
            ),
          ),
        );
        await tester.enterText(find.byKey(numberOfObjectsInputKey),
            testNumberOfObjects.toString());
        verify(() => constraintsFormBloc.add(
              NumberOfObjectsDidChange(testNumberOfJugglers),
            )).called(1);
      });

      testWidgets('maxHeightChanged when max height changes', (tester) async {
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
              child: ConstraintsForm(),
            ),
          ),
        );
        await tester.enterText(
            find.byKey(maxHeightInputKey), testMaxHeight.toString());
        verify(() => constraintsFormBloc.add(
              MaxHeightDidChange(testNumberOfJugglers),
            )).called(1);
      });

      testWidgets('submit when submit button is pressed', (tester) async {
        when(() => constraintsFormBloc.state).thenReturn(
          const ConstraintsFormState(status: FormzStatus.valid),
        );
        //when(() => constraintsFormBloc.submit()).thenAnswer((_) async => null);
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
              child: ConstraintsForm(),
            ),
          ),
        );
        await tester.tap(find.byKey(submitButtonKey));
        verify(() => constraintsFormBloc.add(
              Submit(),
            )).called(1);
      });
    });

    group('renders', () {
      testWidgets('Failure SnackBar when submission fails', (tester) async {
        whenListen(
          constraintsFormBloc,
          Stream.fromIterable(const <ConstraintsFormState>[
            ConstraintsFormState(status: FormzStatus.submissionInProgress),
            ConstraintsFormState(status: FormzStatus.submissionFailure),
          ]),
        );
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
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
        when(() => constraintsFormBloc.state).thenReturn(
            ConstraintsFormState(numberOfJugglers: numberOfJugglers));
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
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
        when(() => constraintsFormBloc.state)
            .thenReturn(ConstraintsFormState(period: period));
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
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
        when(() => constraintsFormBloc.state)
            .thenReturn(ConstraintsFormState(numberOfObjects: numberOfObjects));
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
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
        when(() => constraintsFormBloc.state)
            .thenReturn(ConstraintsFormState(maxHeight: maxHeight));
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
              child: ConstraintsForm(),
            ),
          ),
        );
        expect(find.text('invalid max height'), findsOneWidget);
      });

      testWidgets('disabled submit button when status is not validated',
          (tester) async {
        when(() => constraintsFormBloc.state).thenReturn(
          const ConstraintsFormState(status: FormzStatus.invalid),
        );
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
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
        when(() => constraintsFormBloc.state).thenReturn(
          const ConstraintsFormState(status: FormzStatus.valid),
        );
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
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
      testWidgets('to search results page when patterns did load',
          (tester) async {
        whenListen(
          constraintsFormBloc,
          Stream.fromIterable(const <ConstraintsFormState>[
            ConstraintsFormState(status: FormzStatus.submissionInProgress),
            ConstraintsFormState(status: FormzStatus.submissionSuccess),
          ]),
        );
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
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
