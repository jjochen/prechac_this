// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/screens/home/home.dart';

import '../../../helpers/helpers.dart';

class MockConstraintsFormBloc extends MockCubit<ConstraintsFormState>
    implements ConstraintsFormBloc {}

class MockNumberOfJugglers extends Mock implements NumberOfJugglers {}

class MockPeriod extends Mock implements Period {}

class MockNumberOfObjects extends Mock implements NumberOfObjects {}

class MockMaxHeight extends Mock implements MaxHeight {}

class MockMinNumberOfPasses extends Mock implements MinNumberOfPasses {}

class MockMaxNumberOfPasses extends Mock implements MaxNumberOfPasses {}

class MockContains extends Mock implements Contains {}

void main() {
  const submitButtonKey = Key('constraintsForm_submit_raisedButton');
  const numberOfJugglersInputKey = Key('constraintsForm_numberOfJugglersInput');
  const periodInputKey = Key('constraintsForm_periodInput');
  const numberOfObjectsInputKey = Key('constraintsForm_numberOfObjectsInput');
  const maxHeightInputKey = Key('constraintsForm_maxHeightInput');
  const minNumberOfPassesInputKey =
      Key('constraintsForm_minNumberOfPassesInput');
  const maxNumberOfPassesInputKey =
      Key('constraintsForm_maxNumberOfPassesInput');
  const containsInputKey = Key('constraintsForm_containsInput');
  const progressIndicatorKey = Key('constraintsForm_submit_progressIndicator');

  const testNumberOfJugglers = 5;
  const testPeriod = 6;
  const testNumberOfObjects = 7;
  const testMaxHeight = 8;
  const testMinNumberOfPasses = 3;
  const testMaxNumberOfPasses = 4;
  const testContains = '2p 1';

  group('ConstraintsForm', () {
    registerFallbackValue<ConstraintsFormState>(const ConstraintsFormState());

    late ConstraintsFormBloc constraintsFormBloc;

    setUp(() {
      constraintsFormBloc = MockConstraintsFormBloc();
      when(() => constraintsFormBloc.state)
          .thenReturn(const ConstraintsFormState());
    });

    group('adds', () {
      testWidgets('NumberOfJugglersDidChange when number of jugglers changes',
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

      testWidgets('PeriodDidChange when period changes', (tester) async {
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
              PeriodDidChange(testPeriod),
            )).called(1);
      });

      testWidgets(
          'NumberOfObjectsDidChange '
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
              NumberOfObjectsDidChange(testNumberOfObjects),
            )).called(1);
      });

      testWidgets('MaxHeightDidChange when max height changes', (tester) async {
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
              MaxHeightDidChange(testMaxHeight),
            )).called(1);
      });

      testWidgets(
          'MinNumberOfPassesDidChange when min number of passes changes',
          (tester) async {
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
              child: ConstraintsForm(),
            ),
          ),
        );
        await tester.enterText(find.byKey(minNumberOfPassesInputKey),
            testMinNumberOfPasses.toString());
        verify(() => constraintsFormBloc.add(
              MinNumberOfPassesDidChange(testMinNumberOfPasses),
            )).called(1);
      });

      testWidgets(
          'MaxNumberOfPassesDidChange when max number of passes changes',
          (tester) async {
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
              child: ConstraintsForm(),
            ),
          ),
        );
        await tester.enterText(find.byKey(maxNumberOfPassesInputKey),
            testMaxNumberOfPasses.toString());
        verify(() => constraintsFormBloc.add(
              MaxNumberOfPassesDidChange(testMaxNumberOfPasses),
            )).called(1);
      });

      testWidgets('ContainsDidChange when contains changes', (tester) async {
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
              child: ConstraintsForm(),
            ),
          ),
        );
        await tester.enterText(
            find.byKey(containsInputKey), testContains.toString());
        verify(() => constraintsFormBloc.add(
              ContainsDidChange(testContains),
            )).called(1);
      });

      testWidgets('Submit when submit button is pressed', (tester) async {
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
            ConstraintsFormState(
              status: FormzStatus.submissionFailure,
              errorMessage: 'Message',
            ),
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
        expect(find.text('Message'), findsOneWidget);
      });

      testWidgets(
          'invalid number of jugglers error text '
          'when number of jugglers is invalid', (tester) async {
        final numberOfJugglers = MockNumberOfJugglers();
        when(() => numberOfJugglers.error).thenReturn(
          InputOutOfRangeException('Error: number of jugglers'),
        );
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
        expect(find.text('Error: number of jugglers'), findsOneWidget);
      });

      testWidgets('invalid period error text when period is invalid',
          (tester) async {
        final period = MockPeriod();
        when(() => period.error).thenReturn(
          InputOutOfRangeException('Error: period'),
        );
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
        expect(find.text('Error: period'), findsOneWidget);
      });

      testWidgets(
          'invalid number of objects error text '
          'when number of objects is invalid', (tester) async {
        final numberOfObjects = MockNumberOfObjects();
        when(() => numberOfObjects.error).thenReturn(
          InputOutOfRangeException('Error: number of objects'),
        );
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
        expect(find.text('Error: number of objects'), findsOneWidget);
      });

      testWidgets('invalid max height error text when max height is invalid',
          (tester) async {
        final maxHeight = MockMaxHeight();
        when(() => maxHeight.error).thenReturn(
          InputOutOfRangeException('Error: max height'),
        );
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
        expect(find.text('Error: max height'), findsOneWidget);
      });

      testWidgets(
          'invalid min number of passes error text '
          'when min number of passes is invalid', (tester) async {
        final minNumberOfPasses = MockMinNumberOfPasses();
        when(() => minNumberOfPasses.error).thenReturn(
          InputOutOfRangeException('Error: min number of passes'),
        );
        when(() => constraintsFormBloc.state).thenReturn(
            ConstraintsFormState(minNumberOfPasses: minNumberOfPasses));
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
              child: ConstraintsForm(),
            ),
          ),
        );
        expect(find.text('Error: min number of passes'), findsOneWidget);
      });

      testWidgets(
          'invalid max number of passes error text '
          'when max number of passes is invalid', (tester) async {
        final maxNumberOfPasses = MockMaxNumberOfPasses();
        when(() => maxNumberOfPasses.error).thenReturn(
          InputOutOfRangeException('Error: max number of passes'),
        );
        when(() => constraintsFormBloc.state).thenReturn(
            ConstraintsFormState(maxNumberOfPasses: maxNumberOfPasses));
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
              child: ConstraintsForm(),
            ),
          ),
        );
        expect(find.text('Error: max number of passes'), findsOneWidget);
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

      testWidgets('progress indicator when status is in progress',
          (tester) async {
        when(() => constraintsFormBloc.state).thenReturn(
            ConstraintsFormState(status: FormzStatus.submissionInProgress));
        await tester.pumpApp(
          widget: Scaffold(
            body: BlocProvider.value(
              value: constraintsFormBloc,
              child: ConstraintsForm(),
            ),
          ),
        );
        expect(find.byKey(progressIndicatorKey), findsOneWidget);
      });
    });
  });
}
