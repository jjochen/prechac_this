// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/pattern_repository/pattern_repository.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

import '../../../helpers/helpers.dart';

class MockPatternRepository extends Mock implements PatternRepository {}

void main() {
  group('PatternsBloc', () {
    late PatternRepository patternRepository;

    setUp(() {
      patternRepository = MockPatternRepository();
    });

    test('initial state is HomeState', () {
      expect(
        PatternsBloc(patternRepository: patternRepository).state,
        PatternsInitial(),
      );
    });

    blocTest<PatternsBloc, PatternsState>(
      'emits [PatternsLoading, PatternsLoaded]',
      build: () {
        when(() => patternRepository.patterns(mockParameters))
            .thenAnswer((invocation) async => [mockPattern]);
        return PatternsBloc(patternRepository: patternRepository);
      },
      act: (bloc) => bloc.add(LoadPatterns(mockParameters)),
      expect: () => <PatternsState>[
        PatternsLoading(),
        PatternsLoaded([mockPattern]),
      ],
    );
  });
}
