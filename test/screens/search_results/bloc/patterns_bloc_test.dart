// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

import '../../../helpers/helpers.dart';

class MockPatternsRepository extends Mock implements PatternsRepository {}

void main() {
  group('PatternsBloc', () {
    late PatternsRepository patternsRepository;

    setUp(() {
      patternsRepository = MockPatternsRepository();
    });

    test('initial state is ConstraintsFormState', () {
      expect(
        PatternsBloc(patternsRepository: patternsRepository).state,
        PatternsInitial(),
      );
    });

    blocTest<PatternsBloc, PatternsState>(
      'emits [PatternsLoading, PatternsLoaded]',
      build: () {
        when(() => patternsRepository.patterns(mockParameters))
            .thenAnswer((invocation) async => [mockPattern]);
        return PatternsBloc(patternsRepository: patternsRepository);
      },
      act: (bloc) => bloc.add(LoadPatterns(mockParameters)),
      expect: () => <PatternsState>[
        PatternsLoading(),
        PatternsLoaded([mockPattern]),
      ],
    );
  });
}
