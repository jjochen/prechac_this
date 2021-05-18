// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:prechac_this/screens/home/home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

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

  const validHomeState = HomeState(
    numberOfJugglers: validNumberOfJugglers,
    period: validPeriod,
    numberOfObjects: validNumberOfObjects,
    maxHeight: validMaxHeight,
    status: FormzStatus.valid,
  );

  group('HomeCubit', () {
    test('initial state is HomeState', () {
      expect(HomeCubit().state, HomeState());
    });

    group('numberOfJugglersChanged', () {
      blocTest<HomeCubit, HomeState>(
        'emits [invalid] when numberOfJugglers is invalid',
        build: () => HomeCubit(),
        act: (cubit) =>
            cubit.numberOfJugglersChanged(invalidNumberOfJugglersValue),
        expect: () => const <HomeState>[
          HomeState(
              numberOfJugglers: invalidNumberOfJugglers,
              status: FormzStatus.invalid),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'emits [valid] when values are valid',
        build: () => HomeCubit(),
        seed: () => HomeState(
          period: validPeriod,
          numberOfObjects: validNumberOfObjects,
          maxHeight: validMaxHeight,
        ),
        act: (cubit) =>
            cubit.numberOfJugglersChanged(validNumberOfJugglersValue),
        expect: () => const <HomeState>[
          validHomeState,
        ],
      );
    });

    group('periodChanged', () {
      blocTest<HomeCubit, HomeState>(
        'emits [invalid] when period is invalid',
        build: () => HomeCubit(),
        act: (cubit) => cubit.periodChanged(invalidPeriodValue),
        expect: () => const <HomeState>[
          HomeState(
            period: invalidPeriod,
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'emits [valid] when values are valid',
        build: () => HomeCubit(),
        seed: () => HomeState(
          numberOfJugglers: validNumberOfJugglers,
          numberOfObjects: validNumberOfObjects,
          maxHeight: validMaxHeight,
        ),
        act: (cubit) => cubit.periodChanged(validPeriodValue),
        expect: () => const <HomeState>[
          validHomeState,
        ],
      );
    });

    group('numberOfObjectsChanged', () {
      blocTest<HomeCubit, HomeState>(
        'emits [invalid] when numberOfObjects is invalid',
        build: () => HomeCubit(),
        act: (cubit) =>
            cubit.numberOfObjectsChanged(invalidNumberOfObjectsValue),
        expect: () => const <HomeState>[
          HomeState(
            numberOfObjects: invalidNumberOfObjects,
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'emits [valid] when values are valid',
        build: () => HomeCubit(),
        seed: () => HomeState(
          numberOfJugglers: validNumberOfJugglers,
          period: validPeriod,
          maxHeight: validMaxHeight,
        ),
        act: (cubit) => cubit.numberOfObjectsChanged(validNumberOfObjectsValue),
        expect: () => const <HomeState>[
          validHomeState,
        ],
      );
    });

    group('maxHeightChanged', () {
      blocTest<HomeCubit, HomeState>(
        'emits [invalid] when maxHeight is invalid',
        build: () => HomeCubit(),
        act: (cubit) => cubit.maxHeightChanged(invalidMaxHeightValue),
        expect: () => const <HomeState>[
          HomeState(
            maxHeight: invalidMaxHeight,
            status: FormzStatus.invalid,
          ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'emits [valid] when values are valid',
        build: () => HomeCubit(),
        seed: () => HomeState(
          numberOfJugglers: validNumberOfJugglers,
          period: validPeriod,
          numberOfObjects: validNumberOfObjects,
        ),
        act: (cubit) => cubit.maxHeightChanged(validMaxHeightValue),
        expect: () => const <HomeState>[
          validHomeState,
        ],
      );
    });

    group('submit', () {
      blocTest<HomeCubit, HomeState>(
        'calls submit with correct numberOfJugglers/period',
        build: () => HomeCubit(),
        seed: () => HomeState(
          status: FormzStatus.valid,
          numberOfJugglers: validNumberOfJugglers,
          period: validPeriod,
        ),
        act: (cubit) => cubit.submit(),
        verify: (_) {
          // TODO
        },
      );

      blocTest<HomeCubit, HomeState>(
        'emits [submissionInProgress, submissionSuccess] '
        'when logInWithNumberOfJugglersAndPeriod succeeds',
        build: () => HomeCubit(),
        seed: () => HomeState(
          status: FormzStatus.valid,
          numberOfJugglers: validNumberOfJugglers,
          period: validPeriod,
        ),
        act: (cubit) => cubit.submit(),
        expect: () => const <HomeState>[
          HomeState(
            status: FormzStatus.submissionInProgress,
            numberOfJugglers: validNumberOfJugglers,
            period: validPeriod,
          ),
          HomeState(
            status: FormzStatus.submissionSuccess,
            numberOfJugglers: validNumberOfJugglers,
            period: validPeriod,
          )
        ],
      );

      // blocTest<HomeCubit, HomeState>(
      //   'emits [submissionInProgress, submissionFailure] '
      //   'when submit fails',
      //   build: () {
      //     // TODO
      //     return HomeCubit();
      //   },
      //   seed: () => HomeState(
      //     status: FormzStatus.valid,
      //     numberOfJugglers: validNumberOfJugglers,
      //     period: validPeriod,
      //   ),
      //   act: (cubit) => cubit.submit(),
      //   expect: () => const <HomeState>[
      //     HomeState(
      //       status: FormzStatus.submissionInProgress,
      //       numberOfJugglers: validNumberOfJugglers,
      //       period: validPeriod,
      //     ),
      //     HomeState(
      //       status: FormzStatus.submissionFailure,
      //       numberOfJugglers: validNumberOfJugglers,
      //       period: validPeriod,
      //     )
      //   ],
      // );
    });
  });
}
