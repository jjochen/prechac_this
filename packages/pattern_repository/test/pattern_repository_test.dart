import 'package:pattern_repository/pattern_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PatternRepository', () {
    test('calculates correct landing sites', () {
      final patternRepository = PatternRepository(
          numberOfJugglers: 3,
          numberOfObjects: 6,
          maxHeight: 4,
          minNumberOfPasses: 1,
          maxNumberOfPasses: 2,
          pattern: Pattern([
            Self(height: 4),
            Pass(height: 4 / 3, passingIndex: 1),
            Placeholder(),
            Pass(height: 5 / 3, passingIndex: 2),
          ]));
      expect(
        patternRepository.landingSites(),
        [0, 1, -1, 2],
      );
    });

    test('fetches empty stream of numbers', () async {
      final patternRepository = PatternRepository(
          numberOfJugglers: 2,
          numberOfObjects: 4,
          maxHeight: 4,
          minNumberOfPasses: 1,
          maxNumberOfPasses: 2,
          pattern: Pattern([
            Self(height: 4),
            Placeholder(),
            Self(height: 1),
            Placeholder(),
          ]));
      await expectLater(
          patternRepository.patterns(),
          emitsInOrder([
            [
              Pattern([
                Self(height: 4),
                Pass(height: 2, passingIndex: 1),
                Self(height: 1),
                Pass(height: 1, passingIndex: 1),
              ]),
            ]
          ]));
    });
  });
}
