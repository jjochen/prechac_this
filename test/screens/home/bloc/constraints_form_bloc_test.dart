// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:prechac_this/screens/home/home.dart';

import '../../../helpers/helpers.dart';

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

  const validSearchParameters = SearchParameters(
    numberOfJugglers: validNumberOfJugglersValue,
    period: validPeriodValue,
    numberOfObjects: validNumberOfObjectsValue,
    maxHeight: validMaxHeightValue,
    minNumberOfPasses: validMinNumberOfPassesValue,
    maxNumberOfPasses: validMaxNumberOfPassesValue,
    contains: validContainsValue,
  );

  group('ConstraintsFormBloc', () {
    late PatternsRepository patternsRepository;

    ConstraintsFormBloc buildConstraintsFormBloc() => ConstraintsFormBloc(
          patternsRepository: patternsRepository,
        );

    setUp(() {
      patternsRepository = MockPatternsRepository();
    });

    test('initial state is ConstraintsFormState', () {
      expect(
        buildConstraintsFormBloc().state,
        ConstraintsFormState(),
      );
    });

    group('NumberOfObjectsDidChange', () {
      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [invalid] when numberOfJugglers is invalid',
        build: buildConstraintsFormBloc,
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
        build: buildConstraintsFormBloc,
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
        build: buildConstraintsFormBloc,
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
        build: buildConstraintsFormBloc,
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
        build: buildConstraintsFormBloc,
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
        build: buildConstraintsFormBloc,
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
        build: buildConstraintsFormBloc,
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
        build: buildConstraintsFormBloc,
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
        build: buildConstraintsFormBloc,
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
        build: buildConstraintsFormBloc,
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
        build: buildConstraintsFormBloc,
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
        build: buildConstraintsFormBloc,
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
        build: buildConstraintsFormBloc,
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
        'emits [submissionInProgress, submissionSuccess] '
        'when form is valid',
        setUp: () {
          when(
            () => patternsRepository.findPatterns(
              parameters: validSearchParameters,
            ),
          ).thenAnswer((_) => Future.value([mockPattern]));
        },
        build: buildConstraintsFormBloc,
        seed: () => validConstraintsFormState,
        act: (bloc) => bloc.add(Submit()),
        expect: () => <ConstraintsFormState>[
          validConstraintsFormState.copyWith(
            status: FormzStatus.submissionInProgress,
          ),
          validConstraintsFormState.copyWith(
            status: FormzStatus.submissionSuccess,
            listOfPatterns: [mockPattern],
          ),
        ],
        verify: (_) {
          verify(
            () => patternsRepository.findPatterns(
              parameters: validSearchParameters,
            ),
          ).called(1);
        },
      );

      blocTest<ConstraintsFormBloc, ConstraintsFormState>(
        'emits [submissionInProgress, submissionFailure] '
        'when patternsRepository throws',
        setUp: () {
          when(
            () => patternsRepository.findPatterns(
              parameters: validSearchParameters,
            ),
          ).thenAnswer((_) => Future.error(NoPatternsFoundException()));
        },
        build: buildConstraintsFormBloc,
        seed: () => validConstraintsFormState,
        act: (bloc) => bloc.add(Submit()),
        expect: () => <ConstraintsFormState>[
          validConstraintsFormState.copyWith(
            status: FormzStatus.submissionInProgress,
          ),
          validConstraintsFormState.copyWith(
            status: FormzStatus.submissionFailure,
            exception: NoPatternsFoundException(),
          ),
        ],
        verify: (_) {
          verify(
            () => patternsRepository.findPatterns(
              parameters: validSearchParameters,
            ),
          ).called(1);
        },
      );
    });
  });
}
