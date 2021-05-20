// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/repositories/pattern_repository/pattern_repository.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

class MockPatternRepository extends Mock implements PatternRepository {}

void main() {
  group('PatternsBloc', () {
    final searchParameters = SearchParameters(
      numberOfJugglers: 2,
      period: 4,
      numberOfObjects: 4,
      maxHeight: 4,
    );
    final pattern = Pattern([
      Throw.self(height: 4),
      Throw.pass(height: 2),
      Throw.self(height: 1),
      Throw.pass(height: 1),
    ]);

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
        when(() => patternRepository.patterns(searchParameters))
            .thenAnswer((invocation) async => [pattern]);
        return PatternsBloc(patternRepository: patternRepository);
      },
      act: (bloc) => bloc.add(LoadPatterns(searchParameters)),
      expect: () => <PatternsState>[
        PatternsLoading(),
        PatternsLoaded([pattern]),
      ],
    );
  });
}
