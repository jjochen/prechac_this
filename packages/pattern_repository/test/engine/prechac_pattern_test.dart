import 'package:fraction/fraction.dart';
import 'package:pattern_repository/pattern_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pattern_repository/src/engine/prechac_pattern.dart';

void main() {
  group('PrechacPattern', () {
    group('4 1.3p1 _ 1.6p2', () {
      late Pattern pattern;
      setUp(() {
        pattern = Pattern([
          Throw.self(height: 4),
          Throw(height: Fraction(4, 3), passingIndex: 1),
          Throw.placeholder(),
          Throw(height: Fraction(5, 3), passingIndex: 2),
        ]);
      });

      test('calculates permutations of missing landing sites', () {
        expect(
          pattern
              .permutationsOfPossibleLandingSites(prechator: Fraction(4, 3))
              .toList(),
          [
            [0, 1, 3, 2],
          ],
        );
      });
    });

    group('4 _ 1 _', () {
      late Pattern pattern;
      setUp(() {
        pattern = Pattern([
          Throw.self(height: 4),
          Throw.placeholder(),
          Throw.self(height: 1),
          Throw.placeholder(),
        ]);
      });

      test('calculates permutations of missing landing sites', () {
        expect(
          pattern
              .permutationsOfPossibleLandingSites(prechator: Fraction(4, 2))
              .toList(),
          [
            [0, 1, 3, 2],
            [0, 2, 3, 1],
          ],
        );
      });
    });
  });
}
