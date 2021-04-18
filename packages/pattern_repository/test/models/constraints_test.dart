import 'package:pattern_repository/pattern_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pattern_repository/src/models/constraints.dart';

void main() {
  group('Constraints', () {
    test('supports value comparisons', () {
      expect(
        Constraints(
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
            ])),
        Constraints(
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
            ])),
      );
    });

    test('has correct string representation', () {
      expect(
        Constraints(
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
            ])).toString(),
        'Constraints(2, 4, 4, 1, 2, 4, _, 1, _)',
      );
    });
  });
}
