import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

import '../helpers/helpers.dart';

void main() {
  group('PatternsRepository', () {
    late PatternsRepository patternsRepository;
    setUp(() {
      patternsRepository = PatternsRepository();
    });

    test('findes correct for search parameters on separate isolate', () async {
      final searchParameters = SearchParameters(
        numberOfJugglers: 2,
        period: 2,
        numberOfObjects: 4,
        maxHeight: 4,
        minNumberOfPasses: 2,
        maxNumberOfPasses: 2,
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
      );
      expect(
        PatternsRepository.findPatterns(searchParameters).length,
        38,
      );
    });

    test('prechac this throw up', () {
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

    test('prechac this throw down', () {
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
}
