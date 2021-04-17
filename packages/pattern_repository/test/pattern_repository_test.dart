import 'package:pattern_repository/pattern_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PatternRepository', () {
    late PatternRepository patternRepository;

    setUp(() {
      patternRepository = PatternRepository();
    });

    test('fetches empty stream of numbers', () async {
      final constraints = Constraints(
          numberOfJugglers: 2,
          numberOfObjects: 4,
          maxHeight: 4,
          minNumberOfPasses: 1,
          maxNumberOfPasses: 2,
          pattern: Pattern([
            SimpleThrow(height: 4),
            SimpleThrow.placeholder(),
            SimpleThrow(height: 1),
            SimpleThrow.placeholder(),
          ]));
      await expectLater(
          patternRepository.patterns(constraints),
          emitsInOrder([
            [
              Pattern([
                SimpleThrow(height: 4),
                SimpleThrow(height: 2, passingIndex: 1),
                SimpleThrow(height: 1),
                SimpleThrow(height: 1, passingIndex: 1),
              ]),
            ]
          ]));
    });
  });
}
