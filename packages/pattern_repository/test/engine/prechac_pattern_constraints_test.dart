import 'package:fraction/fraction.dart';
import 'package:pattern_repository/pattern_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pattern_repository/src/engine/prechac_pattern_constraints.dart';

void main() {
  group('PrechacPatternConstraints', () {
    group('4 1.3p1 _ 1.6p2', () {
      late PatternConstraints patternConstraints;
      setUp(() {
        patternConstraints = PatternConstraints([
          ThrowConstraints.self(height: 4),
          ThrowConstraints(height: Fraction(4, 3), passingIndex: 1),
          ThrowConstraints.placeholder(),
          ThrowConstraints(height: Fraction(5, 3), passingIndex: 2),
        ]);
      });

      test('calculates permutations of missing landing sites', () {
        expect(
          patternConstraints
              .permutationsOfPossibleLandingSites(prechator: Fraction(4, 3))
              .toList(),
          [
            [0, 1, 3, 2],
          ],
        );
      });
    });

    group('4 _ 1 _', () {
      late PatternConstraints patternConstraints;
      setUp(() {
        patternConstraints = PatternConstraints([
          ThrowConstraints.self(height: 4),
          ThrowConstraints.placeholder(),
          ThrowConstraints.self(height: 1),
          ThrowConstraints.placeholder(),
        ]);
      });

      test('calculates permutations of missing landing sites', () {
        expect(
          patternConstraints
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
