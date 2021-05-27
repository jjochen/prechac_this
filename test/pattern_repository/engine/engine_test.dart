import 'package:flutter_test/flutter_test.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/pattern_repository/engine/engine.dart';
import 'package:prechac_this/pattern_repository/pattern_repository.dart';

void main() {
  group('Engine', () {
    group('4 1.3p1 _ 1.6p2', () {
      late Engine engine;
      late PatternConstraint patternConstraint;
      setUp(() {
        engine = Engine(
          numberOfJugglers: 3,
          period: 4,
          numberOfObjects: 6,
          maxHeight: 4,
        );
        patternConstraint = PatternConstraint([
          ThrowConstraint.self(height: 4),
          ThrowConstraint(height: Fraction(4, 3), passingIndex: null),
          ThrowConstraint.placeholder(),
          ThrowConstraint(height: Fraction(5, 3), passingIndex: 2),
        ]);
      });

      test('finds correct patterns', () {
        expect(
          engine.fillConstraint(patternConstraint: patternConstraint),
          [
            Pattern([
              Throw.self(height: 4),
              Throw(height: Fraction(4, 3), passingIndex: 1),
              Throw.self(height: 1),
              Throw(height: Fraction(5, 3), passingIndex: 2),
            ]),
          ],
        );
      });

      test('calculates possible throws', () {
        final constraint = ThrowConstraint.placeholder();
        expect(
          engine.possibleThrows(
              throwConstraint: constraint, landingSite: 3, index: 2),
          [
            Throw.self(height: 1),
            Throw(height: Fraction(7, 3), passingIndex: 1),
            Throw(height: Fraction(11, 3), passingIndex: 2),
          ],
        );
      });

      test('calculates possible throws for given height', () {
        final constraint =
            ThrowConstraint(height: Fraction(7, 3), passingIndex: null);
        expect(
          engine.possibleThrows(
              throwConstraint: constraint, landingSite: 3, index: 2),
          [
            Throw(height: Fraction(7, 3), passingIndex: 1),
          ],
        );
      });

      test('calculates possible throws for given passing index', () {
        final constraint = const ThrowConstraint(height: null, passingIndex: 2);
        expect(
          engine.possibleThrows(
              throwConstraint: constraint, landingSite: 3, index: 2),
          [
            Throw(height: Fraction(11, 3), passingIndex: 2),
          ],
        );
      });

      test('calculates possible throws for given passing index and height', () {
        final constraint =
            ThrowConstraint(height: Fraction(5, 3), passingIndex: 2);
        expect(
          engine.possibleThrows(
              throwConstraint: constraint, landingSite: 2, index: 3),
          [
            Throw(height: Fraction(5, 3), passingIndex: 2),
          ],
        );
      });
    });

    group('4 _ 1 _', () {
      late PatternConstraint patternConstraint;
      late Engine engine;
      setUp(() {
        engine = Engine(
          numberOfJugglers: 2,
          period: 4,
          numberOfObjects: 4,
          maxHeight: 4,
          minNumberOfPasses: 2,
        );
        patternConstraint = PatternConstraint([
          ThrowConstraint.self(height: 4),
          ThrowConstraint.placeholder(),
          ThrowConstraint.self(height: 1),
          ThrowConstraint.placeholder(),
        ]);
      });

      test('finds correct patterns', () {
        expect(
          engine.fillConstraint(patternConstraint: patternConstraint),
          [
            Pattern([
              Throw.self(height: 4),
              Throw.pass(height: 2),
              Throw.self(height: 1),
              Throw.pass(height: 1),
            ]),
          ],
        );
      });

      test('calculates possible throws', () {
        final constraint = ThrowConstraint.placeholder();
        expect(
          engine.possibleThrows(
              throwConstraint: constraint, landingSite: 3, index: 2),
          [
            Throw.self(height: 1),
            Throw.pass(height: 3),
          ],
        );
      });

      test('calculates possible throws for given height', () {
        final constraint =
            ThrowConstraint(height: Fraction(1), passingIndex: null);
        expect(
          engine.possibleThrows(
              throwConstraint: constraint, landingSite: 3, index: 2),
          [
            Throw.self(height: 1),
          ],
        );
      });

      test('calculates possible throws for given passing index', () {
        final constraint = const ThrowConstraint(height: null, passingIndex: 1);
        expect(
          engine.possibleThrows(
              throwConstraint: constraint, landingSite: 3, index: 2),
          [
            Throw.pass(height: 3),
          ],
        );
      });

      test('calculates possible throws for given passing index and height', () {
        final constraint =
            ThrowConstraint(height: Fraction(3), passingIndex: 0);
        expect(
          engine.possibleThrows(
              throwConstraint: constraint, landingSite: 2, index: 3),
          [
            Throw.self(height: 3),
          ],
        );
      });

      test('returns empty list as possible throws for invalid height', () {
        final constraint =
            ThrowConstraint(height: Fraction(1), passingIndex: 0);
        expect(
          engine.possibleThrows(
              throwConstraint: constraint, landingSite: 3, index: 3),
          [],
        );
      });

      test('returns empty list as possible throws for invalid passing index',
          () {
        final constraint =
            ThrowConstraint(height: Fraction(1), passingIndex: 0);
        expect(
          engine.possibleThrows(
              throwConstraint: constraint, landingSite: 2, index: 3),
          [],
        );
      });
    });
  });
}
