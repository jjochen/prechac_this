import 'package:flutter_test/flutter_test.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/repositories/pattern_repository/engine/prechac_pattern_constraint.dart';
import 'package:prechac_this/repositories/pattern_repository/pattern_repository.dart';

void main() {
  group('PrechacPatternConstraint', () {
    group('4 1.3p1 _ 1.6p2', () {
      late PatternConstraint patternConstraint;
      setUp(() {
        patternConstraint = PatternConstraint([
          ThrowConstraint.self(height: 4),
          ThrowConstraint(height: Fraction(4, 3), passingIndex: 1),
          ThrowConstraint.placeholder(),
          ThrowConstraint(height: Fraction(5, 3), passingIndex: 2),
        ]);
      });

      test('calculates permutations of missing landing sites', () {
        expect(
          patternConstraint
              .permutationsOfPossibleLandingSites(prechator: Fraction(4, 3))
              .toList(),
          [
            [0, 1, 3, 2],
          ],
        );
      });
    });

    group('4 _ 1 _', () {
      late PatternConstraint patternConstraint;
      setUp(() {
        patternConstraint = PatternConstraint([
          ThrowConstraint.self(height: 4),
          ThrowConstraint.placeholder(),
          ThrowConstraint.self(height: 1),
          ThrowConstraint.placeholder(),
        ]);
      });

      test('calculates permutations of missing landing sites', () {
        expect(
          patternConstraint
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
