// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

import '../helpers/helpers.dart';

void main() {
  group('PatternsRepository', () {
    late PatternsRepository patternsRepository;
    setUp(() {
      patternsRepository = PatternsRepository();
    });

    group('patterns()', () {
      test('findes correct for search parameters on separate isolate',
          () async {
        final searchParameters = SearchParameters(
          numberOfJugglers: 2,
          period: 2,
          numberOfObjects: 4,
          maxHeight: 4,
          minNumberOfPasses: 2,
          maxNumberOfPasses: 2,
          contains: '_p',
        );
        expect(
            patternsRepository.patterns(searchParameters).then((pattern) {
              expect(pattern, [
                Pattern(
                  numberOfJugglers: 2,
                  throwSequence: [Throw.pass(height: 2), Throw.pass(height: 2)],
                ),
                Pattern(
                  numberOfJugglers: 2,
                  throwSequence: [Throw.pass(height: 3), Throw.pass(height: 1)],
                ),
              ]);
            }),
            completes);
      });
    });

    group('findPatterns()', () {
      test('findes correct for search parameters', () {
        // bug in flutter: compute doesn't gather coverage
        final searchParameters = SearchParameters(
          numberOfJugglers: 2,
          period: 2,
          numberOfObjects: 4,
          maxHeight: 4,
        );
        expect(
          PatternsRepository.findPatterns(searchParameters),
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
          PatternsRepository.findPatterns(searchParameters).length,
          6,
        );
      });

      group('throws', () {
        test('ConstraintsInvalidException 3x', () {
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
            () => PatternsRepository.findPatterns(searchParameters),
            throwsA(isA<ConstraintsInvalidException>()),
          );
        });

        test('ConstraintsInvalidException 3 2 _', () {
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
            () => PatternsRepository.findPatterns(searchParameters),
            throwsA(isA<ConstraintsInvalidException>()),
          );
        });

        test('NoPatternsFoundException', () {
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
            () => PatternsRepository.findPatterns(searchParameters),
            throwsA(isA<NoPatternsFoundException>()),
          );
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
