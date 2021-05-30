// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/screens/home/home.dart';

class MockPatternsBloc extends MockBloc<PatternsEvent, PatternsState>
    implements PatternsBloc {}

class FakePatternsEvent extends Fake implements PatternsEvent {}

void main() {
  const invalidNumberOfJugglersValue = 0;
  const invalidNumberOfJugglers =
      NumberOfJugglers.dirty(invalidNumberOfJugglersValue);

  const validNumberOfJugglersValue = 3;
  const validNumberOfJugglers =
      NumberOfJugglers.dirty(validNumberOfJugglersValue);

  const invalidPeriodValue = 0;
  const invalidPeriod = Period.dirty(invalidPeriodValue);

  const validPeriodValue = 2;
  const validPeriod = Period.dirty(validPeriodValue);

  const invalidNumberOfObjectsValue = 0;
  const invalidNumberOfObjects =
      NumberOfObjects.dirty(invalidNumberOfObjectsValue);

  const validNumberOfObjectsValue = 3;
  const validNumberOfObjects = NumberOfObjects.dirty(validNumberOfObjectsValue);

  const invalidMaxHeightValue = 0;
  const invalidMaxHeight = MaxHeight.dirty(invalidMaxHeightValue);

  const validMaxHeightValue = 2;
  const validMaxHeight = MaxHeight.dirty(validMaxHeightValue);

  const validConstraintsFormState = ConstraintsFormState(
    numberOfJugglers: validNumberOfJugglers,
    period: validPeriod,
    numberOfObjects: validNumberOfObjects,
    maxHeight: validMaxHeight,
    status: FormzStatus.valid,
  );

  group('ConstraintsFormBloc', () {
    late PatternsBloc patternsBloc;

    setUp(() {
      registerFallbackValue(FakePatternsEvent());
      registerFallbackValue(PatternsInitial());
      patternsBloc = MockPatternsBloc();
    });

    test('initial state is ConstraintsFormState', () {
      expect(
          ConstraintsFormBloc(
            patternsBloc: patternsBloc,
          ).state,
          ConstraintsFormState());
    });

    group('NumberOfObjectsDidChange', () {
      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [invalid] when numberOfJugglers is invalid',
        build: () => ConstraintsFormBloc(
          patternsBloc: patternsBloc,
        ),
        act: (bloc) =>
            bloc.add(NumberOfJugglersDidChange(invalidNumberOfJugglersValue)),
        expect: () => const <ConstraintsFormState>[
          ConstraintsFormState(
              numberOfJugglers: invalidNumberOfJugglers,
              status: FormzStatus.invalid),
        ],
      );

      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [valid] when values are valid',
        build: () => ConstraintsFormBloc(
          patternsBloc: patternsBloc,
        ),
        seed: () => ConstraintsFormState(
          period: validPeriod,
          numberOfObjects: validNumberOfObjects,
          maxHeight: validMaxHeight,
        ),
        act: (bloc) =>
            bloc.add(NumberOfJugglersDidChange(validNumberOfJugglersValue)),
        expect: () => const <ConstraintsFormState>[
          validConstraintsFormState,
        ],
      );
    });

    group('PeriodDidChange', () {
      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [invalid] when period is invalid',
        build: () => ConstraintsFormBloc(
          patternsBloc: patternsBloc,
        ),
        act: (bloc) => bloc.add(PeriodDidChange(invalidPeriodValue)),
        expect: () => const <ConstraintsFormState>[
          ConstraintsFormState(
            period: invalidPeriod,
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [valid] when values are valid',
        build: () => ConstraintsFormBloc(
          patternsBloc: patternsBloc,
        ),
        seed: () => ConstraintsFormState(
          numberOfJugglers: validNumberOfJugglers,
          numberOfObjects: validNumberOfObjects,
          maxHeight: validMaxHeight,
        ),
        act: (bloc) => bloc.add(PeriodDidChange(validPeriodValue)),
        expect: () => const <ConstraintsFormState>[
          validConstraintsFormState,
        ],
      );
    });

    group('NumberOfObjectsDidChange', () {
      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [invalid] when numberOfObjects is invalid',
        build: () => ConstraintsFormBloc(
          patternsBloc: patternsBloc,
        ),
        act: (bloc) =>
            bloc.add(NumberOfObjectsDidChange(invalidNumberOfObjectsValue)),
        expect: () => const <ConstraintsFormState>[
          ConstraintsFormState(
            numberOfObjects: invalidNumberOfObjects,
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [valid] when values are valid',
        build: () => ConstraintsFormBloc(
          patternsBloc: patternsBloc,
        ),
        seed: () => ConstraintsFormState(
          numberOfJugglers: validNumberOfJugglers,
          period: validPeriod,
          maxHeight: validMaxHeight,
        ),
        act: (bloc) =>
            bloc.add(NumberOfObjectsDidChange(validNumberOfObjectsValue)),
        expect: () => const <ConstraintsFormState>[
          validConstraintsFormState,
        ],
      );
    });

    group('MaxHeightDidChange', () {
      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [invalid] when maxHeight is invalid',
        build: () => ConstraintsFormBloc(
          patternsBloc: patternsBloc,
        ),
        act: (bloc) => bloc.add(MaxHeightDidChange(invalidMaxHeightValue)),
        expect: () => const <ConstraintsFormState>[
          ConstraintsFormState(
            maxHeight: invalidMaxHeight,
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [valid] when values are valid',
        build: () => ConstraintsFormBloc(
          patternsBloc: patternsBloc,
        ),
        seed: () => ConstraintsFormState(
          numberOfJugglers: validNumberOfJugglers,
          period: validPeriod,
          numberOfObjects: validNumberOfObjects,
        ),
        act: (bloc) => bloc.add(MaxHeightDidChange(validMaxHeightValue)),
        expect: () => const <ConstraintsFormState>[
          validConstraintsFormState,
        ],
      );
    });

    group('Submit', () {
      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'add LoadPatterns with correct search parameters',
        build: () => ConstraintsFormBloc(
          patternsBloc: patternsBloc,
        ),
        seed: () => ConstraintsFormState(
          status: FormzStatus.valid,
          numberOfJugglers: validNumberOfJugglers,
          period: validPeriod,
        ),
        act: (bloc) => bloc.add(Submit()),
        verify: (_) {
          // TODO
        },
      );

      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when submit succeeds',
        build: () => ConstraintsFormBloc(
          // TODO
          patternsBloc: patternsBloc,
        ),
        seed: () => ConstraintsFormState(
          status: FormzStatus.valid,
          numberOfJugglers: validNumberOfJugglers,
          period: validPeriod,
        ),
        act: (bloc) => bloc.add(Submit()),
        expect: () => const <ConstraintsFormState>[
          ConstraintsFormState(
            status: FormzStatus.submissionInProgress,
            numberOfJugglers: validNumberOfJugglers,
            period: validPeriod,
          ),
          ConstraintsFormState(
            status: FormzStatus.submissionSuccess,
            numberOfJugglers: validNumberOfJugglers,
            period: validPeriod,
          )
        ],
      );

      // blocTest<ConstraintsFormBloc, ConstraintsFormState>(
      //   'emits [submissionInProgress, submissionFailure] '
      //   'when submit fails',
      //   build: () {
      //     // TODO
      //     return ConstraintsFormBloc();
      //   },
      //   seed: () => ConstraintsFormState(
      //     status: FormzStatus.valid,
      //     numberOfJugglers: validNumberOfJugglers,
      //     period: validPeriod,
      //   ),
      //   act: (cubit) => cubit.submit(),
      //   expect: () => const <ConstraintsFormState>[
      //     ConstraintsFormState(
      //       status: FormzStatus.submissionInProgress,
      //       numberOfJugglers: validNumberOfJugglers,
      //       period: validPeriod,
      //     ),
      //     ConstraintsFormState(
      //       status: FormzStatus.submissionFailure,
      //       numberOfJugglers: validNumberOfJugglers,
      //       period: validPeriod,
      //     )
      //   ],
      // );
    });
  });
}
