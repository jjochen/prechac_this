// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:prechac_this/home/home.dart';
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

  group('HomeCubit', () {
    test('initial state is HomeState', () {
      expect(HomeCubit().state, HomeState());
    });

    group('numberOfJugglersChanged', () {
      blocTest<HomeCubit, HomeState>(
        'emits [invalid] when numberOfJugglers/period are invalid',
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
        'emits [valid] when numberOfJugglers/period are valid',
        build: () => HomeCubit(),
        seed: () => HomeState(period: validPeriod),
        act: (cubit) =>
            cubit.numberOfJugglersChanged(validNumberOfJugglersValue),
        expect: () => const <HomeState>[
          HomeState(
            numberOfJugglers: validNumberOfJugglers,
            period: validPeriod,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('periodChanged', () {
      blocTest<HomeCubit, HomeState>(
        'emits [invalid] when numberOfJugglers/period are invalid',
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
        'emits [valid] when numberOfJugglers/period are valid',
        build: () => HomeCubit(),
        seed: () => HomeState(numberOfJugglers: validNumberOfJugglers),
        act: (cubit) => cubit.periodChanged(validPeriodValue),
        expect: () => const <HomeState>[
          HomeState(
            numberOfJugglers: validNumberOfJugglers,
            period: validPeriod,
            status: FormzStatus.valid,
          ),
        ],
      );
    });

    group('submit', () {
      blocTest<HomeCubit, HomeState>(
        'does nothing when status is not validated',
        build: () => HomeCubit(),
        act: (cubit) => cubit.submit(),
        expect: () => const <HomeState>[],
      );

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
