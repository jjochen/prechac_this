// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:prechac_this/screens/home/home.dart';

import '../../../helpers/helpers.dart';

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

  const invalidMinNumberOfPassesValue = 25;
  const invalidMinNumberOfPasses =
      MinNumberOfPasses.dirty(invalidMinNumberOfPassesValue);

  const validMinNumberOfPassesValue = 2;
  const validMinNumberOfPasses =
      MinNumberOfPasses.dirty(validMinNumberOfPassesValue);

  const invalidMaxNumberOfPassesValue = 25;
  const invalidMaxNumberOfPasses =
      MaxNumberOfPasses.dirty(invalidMaxNumberOfPassesValue);

  const validMaxNumberOfPassesValue = 5;
  const validMaxNumberOfPasses =
      MaxNumberOfPasses.dirty(validMaxNumberOfPassesValue);

  const validContainsValue = '2p 1';
  const validContains = Contains.dirty(validContainsValue);

  const validConstraintsFormState = ConstraintsFormState(
    numberOfJugglers: validNumberOfJugglers,
    period: validPeriod,
    numberOfObjects: validNumberOfObjects,
    maxHeight: validMaxHeight,
    minNumberOfPasses: validMinNumberOfPasses,
    maxNumberOfPasses: validMaxNumberOfPasses,
    contains: validContains,
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
        ConstraintsFormState(),
      );
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
          period: validPeriod,
          numberOfObjects: validNumberOfObjects,
          maxHeight: validMaxHeight,
          minNumberOfPasses: validMinNumberOfPasses,
          maxNumberOfPasses: validMaxNumberOfPasses,
          contains: validContains,
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
          minNumberOfPasses: validMinNumberOfPasses,
          maxNumberOfPasses: validMaxNumberOfPasses,
          contains: validContains,
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
          minNumberOfPasses: validMinNumberOfPasses,
          maxNumberOfPasses: validMaxNumberOfPasses,
          contains: validContains,
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
          minNumberOfPasses: validMinNumberOfPasses,
          maxNumberOfPasses: validMaxNumberOfPasses,
          contains: validContains,
        ),
        act: (bloc) => bloc.add(MaxHeightDidChange(validMaxHeightValue)),
        expect: () => const <ConstraintsFormState>[
          validConstraintsFormState,
        ],
      );
    });

    group('MinNumberOfPassesDidChange', () {
      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [invalid] when minNumberOfPasses is invalid',
        build: () => ConstraintsFormBloc(
          patternsBloc: patternsBloc,
        ),
        act: (bloc) => bloc.add(
          MinNumberOfPassesDidChange(
            invalidMinNumberOfPassesValue,
          ),
        ),
        expect: () => const <ConstraintsFormState>[
          ConstraintsFormState(
            minNumberOfPasses: invalidMinNumberOfPasses,
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
          maxHeight: validMaxHeight,
          maxNumberOfPasses: validMaxNumberOfPasses,
          contains: validContains,
        ),
        act: (bloc) => bloc.add(
          MinNumberOfPassesDidChange(
            validMinNumberOfPassesValue,
          ),
        ),
        expect: () => const <ConstraintsFormState>[
          validConstraintsFormState,
        ],
      );
    });

    group('MaxNumberOfPassesDidChange', () {
      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [invalid] when maxNumberOfPasses is invalid',
        build: () => ConstraintsFormBloc(
          patternsBloc: patternsBloc,
        ),
        act: (bloc) => bloc.add(
          MaxNumberOfPassesDidChange(
            invalidMaxNumberOfPassesValue,
          ),
        ),
        expect: () => const <ConstraintsFormState>[
          ConstraintsFormState(
            maxNumberOfPasses: invalidMaxNumberOfPasses,
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
          maxHeight: validMaxHeight,
          minNumberOfPasses: validMinNumberOfPasses,
          contains: validContains,
        ),
        act: (bloc) => bloc.add(
          MaxNumberOfPassesDidChange(
            validMaxNumberOfPassesValue,
          ),
        ),
        expect: () => const <ConstraintsFormState>[
          validConstraintsFormState,
        ],
      );
    });

    group('Contains', () {
      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [valid] when values are valid',
        build: () => ConstraintsFormBloc(
          patternsBloc: patternsBloc,
        ),
        seed: () => ConstraintsFormState(
          numberOfJugglers: validNumberOfJugglers,
          period: validPeriod,
          numberOfObjects: validNumberOfObjects,
          maxHeight: validMaxHeight,
          minNumberOfPasses: validMinNumberOfPasses,
          maxNumberOfPasses: validMaxNumberOfPasses,
        ),
        act: (bloc) => bloc.add(
          ContainsDidChange(
            validContainsValue,
          ),
        ),
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
          numberOfObjects: validNumberOfObjects,
          maxHeight: validMaxHeight,
          minNumberOfPasses: validMinNumberOfPasses,
          maxNumberOfPasses: validMaxNumberOfPasses,
          contains: validContains,
        ),
        act: (bloc) => bloc.add(Submit()),
        verify: (_) {
          final searchParameters = SearchParameters(
            numberOfJugglers: validNumberOfJugglersValue,
            period: validPeriodValue,
            numberOfObjects: validNumberOfObjectsValue,
            maxHeight: validMaxHeightValue,
            minNumberOfPasses: validMinNumberOfPassesValue,
            maxNumberOfPasses: validMaxNumberOfPassesValue,
            contains: validContainsValue,
          );
          verify(
            () => patternsBloc.add(
              LoadPatterns(searchParameters),
            ),
          ).called(1);
        },
      );

      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [submissionInProgress]',
        build: () => ConstraintsFormBloc(
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
        ],
      );
    });

    group('PatternsDidLoad', () {
      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [submissionSuccess] when patterns did load',
        build: () => ConstraintsFormBloc(
          patternsBloc: patternsBloc,
        ),
        act: (bloc) => bloc.add(PatternsDidLoad()),
        expect: () => const <ConstraintsFormState>[
          ConstraintsFormState(
            status: FormzStatus.submissionSuccess,
          ),
        ],
      );

      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'PatternLoaded is passed on from patterns bloc',
        build: () {
          whenListen(
            patternsBloc,
            Stream.fromIterable(<PatternsState>[
              PatternsLoading(),
              PatternsLoaded([mockPattern]),
            ]),
          );
          return ConstraintsFormBloc(
            patternsBloc: patternsBloc,
          );
        },
        expect: () => const <ConstraintsFormState>[
          ConstraintsFormState(
            status: FormzStatus.submissionSuccess,
          ),
        ],
      );
    });

    group('PatternsDidNotLoad', () {
      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [submissionFailure] when patterns did not load',
        build: () => ConstraintsFormBloc(
          patternsBloc: patternsBloc,
        ),
        act: (bloc) => bloc.add(
          PatternsDidNotLoad(ConstraintsInvalidException()),
        ),
        expect: () => <ConstraintsFormState>[
          ConstraintsFormState(
            status: FormzStatus.submissionFailure,
            error: ConstraintsInvalidException(),
          ),
        ],
      );

      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'PatternsNotLoaded is passed on from patterns bloc',
        build: () {
          whenListen(
            patternsBloc,
            Stream.fromIterable(<PatternsState>[
              PatternsLoading(),
              PatternsNotLoaded(NoPatternsFoundException()),
            ]),
          );
          return ConstraintsFormBloc(
            patternsBloc: patternsBloc,
          );
        },
        expect: () => <ConstraintsFormState>[
          ConstraintsFormState(
            status: FormzStatus.submissionFailure,
            error: NoPatternsFoundException(),
          ),
        ],
      );
    });
  });
}
