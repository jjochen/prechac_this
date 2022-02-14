// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/core/computer.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

import '../helpers/helpers.dart';

class MockComputer extends Mock
    implements Computer<SearchParameters, List<Pattern>> {}

void main() {
  group('PatternsRepository', () {
    late PatternsRepository patternsRepository;
    late Computer<SearchParameters, List<Pattern>> computer;
    setUp(() {
      computer = MockComputer();
      patternsRepository = PatternsRepository(
        computer: computer,
      );
    });

    group('findPatterns()', () {
      final searchParameters = SearchParameters(
        numberOfJugglers: 2,
        period: 4,
        numberOfObjects: 4,
        maxHeight: 1,
      );

      test('findes correct for search parameters on separate isolate',
          () async {
        when(() => computer.run(any(), searchParameters))
            .thenAnswer((_) => Future.value([mockPattern]));
        expect(
          patternsRepository.findPatterns(parameters: searchParameters),
          completion(equals([mockPattern])),
        );
        verify(() => computer.run(any(), searchParameters)).called(1);
      });

      test('forwards Exception', () async {
        when(() => computer.run(any(), searchParameters))
            .thenThrow(NoPatternsFoundException());
        expect(
          () => patternsRepository.findPatterns(parameters: searchParameters),
          throwsA(NoPatternsFoundException()),
        );
      });

      test('cancel()', () async {
        patternsRepository.cancel();
        verify(() => computer.cancelComputation()).called(1);
      });
    });

    group('findPatternsSync()', () {
      test('findes correct for search parameters', () {
        // bug in flutter: compute doesn't gather coverage
        final searchParameters = SearchParameters(
          numberOfJugglers: 2,
          period: 2,
          numberOfObjects: 4,
          maxHeight: 4,
        );
        expect(
          PatternsRepository.findPatternsSync(searchParameters),
          [
            Pattern(
              numberOfJugglers: 2,
              throwSequence: [Throw.pass(height: 2), Throw.pass(height: 2)],
            ),
            Pattern(
              numberOfJugglers: 2,
              throwSequence: [Throw.pass(height: 3), Throw.pass(height: 1)],
            ),
          ],
        );
      });

      test('findes correct number of patterns', () {
        // bug in flutter: compute doesn't gather coverage
        final searchParameters = SearchParameters(
          numberOfJugglers: 2,
          period: 4,
          numberOfObjects: 4,
          maxHeight: 4,
          minNumberOfPasses: 1,
          maxNumberOfPasses: 4,
          contains: '3p _ _p',
        );
        expect(
          PatternsRepository.findPatternsSync(searchParameters).length,
          6,
        );
      });

      group('throws', () {
        group('ConstraintsInvalidException', () {
          test('contains 3x', () {
            // bug in flutter: compute doesn't gather coverage
            final searchParameters = SearchParameters(
              numberOfJugglers: 2,
              period: 4,
              numberOfObjects: 4,
              maxHeight: 4,
              minNumberOfPasses: 1,
              maxNumberOfPasses: 4,
              contains: '3x',
            );
            expect(
              () => PatternsRepository.findPatternsSync(searchParameters),
              throwsA(isA<ConstraintsInvalidException>()),
            );
          });
        });

        group('NoPatternsFoundException', () {
          test('when contains 4p 4p with 2 objects', () {
            // bug in flutter: compute doesn't gather coverage
            final searchParameters = SearchParameters(
              numberOfJugglers: 2,
              period: 4,
              numberOfObjects: 2,
              maxHeight: 4,
              minNumberOfPasses: 1,
              maxNumberOfPasses: 4,
              contains: '4p 4p',
            );
            expect(
              () => PatternsRepository.findPatternsSync(searchParameters),
              throwsA(isA<NoPatternsFoundException>()),
            );
          });

          test('when contains  3 2 _', () {
            // bug in flutter: compute doesn't gather coverage
            final searchParameters = SearchParameters(
              numberOfJugglers: 1,
              period: 3,
              numberOfObjects: 3,
              maxHeight: 5,
              minNumberOfPasses: 0,
              maxNumberOfPasses: 3,
              contains: '3 2 _',
            );
            expect(
              () => PatternsRepository.findPatternsSync(searchParameters),
              throwsA(isA<NoPatternsFoundException>()),
            );
          });
        });
      });
    });

    group('prechacThisThrow()', () {
      test('up', () {
        expect(
          patternsRepository.prechacThisThrow(
            pattern: mockPattern,
            index: 1,
            direction: PrechacDirection.up,
          ),
          Pattern(
            numberOfJugglers: 2,
            throwSequence: [
              Throw.self(height: 4),
              Throw.self(height: 4),
              Throw.self(height: 1),
              Throw.pass(height: 1),
            ],
          ),
        );
      });

      test('down', () {
        expect(
          patternsRepository.prechacThisThrow(
            pattern: mockPattern,
            index: 0,
            direction: PrechacDirection.down,
          ),
          Pattern(
            numberOfJugglers: 2,
            throwSequence: [
              Throw.pass(height: 2),
              Throw.pass(height: 2),
              Throw.self(height: 1),
              Throw.pass(height: 1),
            ],
          ),
        );
      });
    });
  });
}
