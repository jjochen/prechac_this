// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/engine/prechac_pattern_constraint.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

void main() {
  group('PrechacPatternConstraint', () {
    group('4 1.3p1 _ 1.6p2', () {
      late PatternConstraint patternConstraint;
      setUp(() {
        patternConstraint = PatternConstraint(
          numberOfJugglers: 3,
          numberOfObjects: 4,
          maxHeight: 4,
          minNumberOfPasses: 1,
          maxNumberOfPasses: 4,
          throwSequence: [
            ThrowConstraint.self(height: 4),
            ThrowConstraint(height: Fraction(4, 3), passingIndex: 1),
            ThrowConstraint.placeholder(),
            ThrowConstraint(height: Fraction(5, 3), passingIndex: 2),
          ],
        );
      });

      test('calculates permutations of missing landing sites', () {
        expect(
          patternConstraint.permutationsOfPossibleLandingSites().toList(),
          [
            [0, 1, 3, 2],
          ],
        );
      });

      test('calculates possible throws', () {
        expect(
          patternConstraint.possibleThrows(
            index: 2,
            landingSite: 3,
          ),
          [
            Throw.self(height: 1),
            Throw(height: Fraction(7, 3), passingIndex: 1),
            Throw(height: Fraction(11, 3), passingIndex: 2),
          ],
        );
      });

      test('calculates possible throws for given height', () {
        final newPatternConstraint = patternConstraint.copyWithThrow(
          newThrow: ThrowConstraint(
            height: Fraction(7, 3),
            passingIndex: null,
          ),
          index: 2,
        );
        expect(
          newPatternConstraint.possibleThrows(
            index: 2,
            landingSite: 3,
          ),
          [
            Throw(height: Fraction(7, 3), passingIndex: 1),
          ],
        );
      });

      test('calculates possible throws for fuzzy height', () {
        final newPatternConstraint = patternConstraint.copyWithThrow(
          newThrow: ThrowConstraint.pass(height: 2.3),
          index: 2,
        );
        expect(
          newPatternConstraint.possibleThrows(
            index: 2,
            landingSite: 3,
          ),
          [
            Throw(height: Fraction(7, 3), passingIndex: 1),
          ],
        );
      });

      test('calculates possible throws for given passing index', () {
        final newPatternConstraint = patternConstraint.copyWithThrow(
          newThrow: ThrowConstraint(height: null, passingIndex: 2),
          index: 2,
        );
        expect(
          newPatternConstraint.possibleThrows(
            index: 2,
            landingSite: 3,
          ),
          [
            Throw(height: Fraction(11, 3), passingIndex: 2),
          ],
        );
      });

      test('calculates possible throws for given passing index and height', () {
        final newPatternConstraint = patternConstraint.copyWithThrow(
          newThrow: ThrowConstraint(height: Fraction(5, 3), passingIndex: 2),
          index: 3,
        );
        expect(
          newPatternConstraint.possibleThrows(
            index: 3,
            landingSite: 2,
          ),
          [
            Throw(height: Fraction(5, 3), passingIndex: 2),
          ],
        );
      });

      test(
          'calculates possible throws for given passing index and fuzzy height',
          () {
        final newPatternConstraint = patternConstraint.copyWithThrow(
          newThrow: ThrowConstraint.pass(height: 1.6, passingIndex: 2),
          index: 3,
        );
        expect(
          newPatternConstraint.possibleThrows(
            index: 3,
            landingSite: 2,
          ),
          [
            Throw(height: Fraction(5, 3), passingIndex: 2),
          ],
        );
      });
    });

    group('4 _ 1 _', () {
      late PatternConstraint patternConstraint;
      setUp(() {
        patternConstraint = PatternConstraint(
          numberOfJugglers: 2,
          numberOfObjects: 4,
          maxHeight: 4,
          minNumberOfPasses: 0,
          maxNumberOfPasses: 4,
          throwSequence: [
            ThrowConstraint.self(height: 4),
            ThrowConstraint.placeholder(),
            ThrowConstraint.self(height: 1),
            ThrowConstraint.placeholder(),
          ],
        );
      });

      test('calculates permutations of missing landing sites', () {
        expect(
          patternConstraint.permutationsOfPossibleLandingSites().toList(),
          [
            [0, 1, 3, 2],
            [0, 2, 3, 1],
          ],
        );
      });

      test('calculates possible throws', () {
        final newPatternConstraint = patternConstraint.copyWithThrow(
          newThrow: ThrowConstraint.placeholder(),
          index: 2,
        );
        expect(
          newPatternConstraint.possibleThrows(
            index: 2,
            landingSite: 3,
          ),
          [
            Throw.self(height: 1),
            Throw.pass(height: 3),
          ],
        );
      });

      test('calculates possible throws for given height', () {
        final newPatternConstraint = patternConstraint.copyWithThrow(
          newThrow: ThrowConstraint(height: Fraction(1), passingIndex: null),
          index: 2,
        );
        expect(
          newPatternConstraint.possibleThrows(
            index: 2,
            landingSite: 3,
          ),
          [
            Throw.self(height: 1),
          ],
        );
      });

      test('calculates possible throws limited to passes', () {
        final newPatternConstraint = patternConstraint.copyWithThrow(
          newThrow: ThrowConstraint(
            height: null,
            passingIndex: null,
            limitToPass: true,
          ),
          index: 2,
        );
        expect(
          newPatternConstraint.possibleThrows(
            index: 2,
            landingSite: 3,
          ),
          [
            Throw.pass(height: 3),
          ],
        );
      });

      test('calculates possible throws for given passing index', () {
        final newPatternConstraint = patternConstraint.copyWithThrow(
          newThrow: ThrowConstraint(height: null, passingIndex: 1),
          index: 2,
        );
        expect(
          newPatternConstraint.possibleThrows(
            index: 2,
            landingSite: 3,
          ),
          [
            Throw.pass(height: 3),
          ],
        );
      });

      test('calculates possible throws for given passing index and height', () {
        final newPatternConstraint = patternConstraint.copyWithThrow(
          newThrow: ThrowConstraint.self(height: 3),
          index: 3,
        );
        expect(
          newPatternConstraint.possibleThrows(
            index: 3,
            landingSite: 2,
          ),
          [
            Throw.self(height: 3),
          ],
        );
      });

      test('returns empty list as possible throws for invalid height', () {
        final newPatternConstraint = patternConstraint.copyWithThrow(
          newThrow: ThrowConstraint(height: Fraction(1), passingIndex: 0),
          index: 3,
        );
        expect(
          newPatternConstraint.possibleThrows(
            index: 3,
            landingSite: 3,
          ),
          [],
        );
      });

      test('returns empty list as possible throws for invalid passing index',
          () {
        final newPatternConstraint = patternConstraint.copyWithThrow(
          newThrow: ThrowConstraint(height: Fraction(1), passingIndex: 0),
          index: 3,
        );
        expect(
          newPatternConstraint.possibleThrows(
            index: 3,
            landingSite: 2,
          ),
          [],
        );
      });
    });
  });
}
