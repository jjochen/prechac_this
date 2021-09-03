// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/navigation/cubit/navigation_cubit.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';

import '../../helpers/helpers.dart';

void main() {
  group('NavigationCubit', () {
    late PatternsBloc mockPatternsBloc;

    setUp(() {
      registerFallbackValue(FakePatternsEvent());
      registerFallbackValue(PatternsInitial());
      mockPatternsBloc = MockPatternsBloc();
    });

    test('initial state is NavigationState()', () {
      expect(
        NavigationCubit(patternsBloc: mockPatternsBloc).state,
        NavigationState(),
      );
    });

    blocTest<NavigationCubit, NavigationState>(
      'emits correct NavigationState when patterns did load',
      build: () {
        whenListen(
          mockPatternsBloc,
          Stream.fromIterable(<PatternsState>[
            PatternsLoading(),
            PatternsLoaded([mockPattern]),
          ]),
        );
        return NavigationCubit(patternsBloc: mockPatternsBloc);
      },
      expect: () => <NavigationState>[
        NavigationState(listOfPatterns: [mockPattern]),
      ],
    );

    group('seed NavigationCubit(null, null, false)', () {
      group('act navigateToAttributions()', () {
        blocTest<NavigationCubit, NavigationState>(
          'emits [NavigationCubit(null, null, true)]',
          build: () => NavigationCubit(patternsBloc: mockPatternsBloc),
          act: (cubit) => cubit.navigateToAttributions(),
          expect: () => <NavigationState>[
            NavigationState(showAttributions: true),
          ],
        );
      });

      group('act navigateToListOfPatterns()', () {
        blocTest<NavigationCubit, NavigationState>(
          'emits [NavigationCubit(listOfPatterns, null, false)]',
          build: () => NavigationCubit(patternsBloc: mockPatternsBloc),
          act: (cubit) => cubit.navigateToListOfPatterns([mockPattern]),
          expect: () => <NavigationState>[
            NavigationState(listOfPatterns: [mockPattern]),
          ],
        );
      });

      group('act navigateToPatternDetailView()', () {
        blocTest<NavigationCubit, NavigationState>(
          'emits [NavigationCubit(null, pattern, false)]',
          build: () => NavigationCubit(patternsBloc: mockPatternsBloc),
          act: (cubit) => cubit.navigateToPatternDetailView(mockPattern),
          expect: () => <NavigationState>[
            NavigationState(currentPattern: mockPattern),
          ],
        );
      });

      group('act pop()', () {
        blocTest<NavigationCubit, NavigationState>(
          'emits []',
          build: () => NavigationCubit(patternsBloc: mockPatternsBloc),
          seed: () => NavigationState(),
          act: (cubit) => cubit.pop(),
          expect: () => <NavigationState>[],
        );
      });
    });

    group('seed NavigationCubit([pattern], null, false)', () {
      group('act pop()', () {
        blocTest<NavigationCubit, NavigationState>(
          'emits [NavigationState(null, null, false)]',
          build: () => NavigationCubit(patternsBloc: mockPatternsBloc),
          seed: () => NavigationState(
            listOfPatterns: [mockPattern],
          ),
          act: (cubit) => cubit.pop(),
          expect: () => <NavigationState>[
            NavigationState(),
          ],
        );
      });
    });

    group('seed NavigationCubit([pattern], null, true)', () {
      group('act pop()', () {
        blocTest<NavigationCubit, NavigationState>(
          'emits [NavigationState([pattern], null, false)]',
          build: () => NavigationCubit(patternsBloc: mockPatternsBloc),
          seed: () => NavigationState(
            listOfPatterns: [mockPattern],
            showAttributions: true,
          ),
          act: (cubit) => cubit.pop(),
          expect: () => <NavigationState>[
            NavigationState(
              listOfPatterns: [mockPattern],
            ),
          ],
        );
      });
    });

    group('seed NavigationCubit([pattern], pattern, false)', () {
      group('act pop()', () {
        blocTest<NavigationCubit, NavigationState>(
          'emits [NavigationState([pattern], null, false)]',
          build: () => NavigationCubit(patternsBloc: mockPatternsBloc),
          seed: () => NavigationState(
            listOfPatterns: [mockPattern],
            currentPattern: mockPattern,
          ),
          act: (cubit) => cubit.pop(),
          expect: () => <NavigationState>[
            NavigationState(
              listOfPatterns: [mockPattern],
            ),
          ],
        );
      });
    });
  });
}
