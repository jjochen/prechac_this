// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/engine/engine.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

void main() {
  group('Engine', () {
    group('4 1.3p_ _ 1.6p2', () {
      late Engine engine;
      late PatternConstraint patternConstraint;
      setUp(() {
        patternConstraint = PatternConstraint(
          numberOfJugglers: 3,
          throwSequence: [
            ThrowConstraint.self(height: 4),
            ThrowConstraint.pass(height: 1.3),
            ThrowConstraint.placeholder(),
            ThrowConstraint(height: Fraction(5, 3), passingIndex: 2),
          ],
        );
        engine = Engine(
          numberOfObjects: 6,
          maxHeight: 4,
          minNumberOfPasses: 1,
          maxNumberOfPasses: patternConstraint.period,
        );
      });

      test('finds correct patterns', () {
        expect(
          engine.fillConstraint(patternConstraint: patternConstraint),
          [
            Pattern(
              numberOfJugglers: 3,
              throwSequence: [
                Throw.self(height: 4),
                Throw(height: Fraction(4, 3), passingIndex: 1),
                Throw.self(height: 1),
                Throw(height: Fraction(5, 3), passingIndex: 2),
              ],
            ),
          ],
        );
      });

      test('calculates possible throws', () {
        final constraint = ThrowConstraint.placeholder();
        expect(
          engine.possibleThrows(
            throwConstraint: constraint,
            landingSite: 3,
            index: 2,
            numberOfJugglers: patternConstraint.numberOfJugglers,
            period: patternConstraint.period,
            prechator: patternConstraint.prechator,
          ),
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
            throwConstraint: constraint,
            landingSite: 3,
            index: 2,
            numberOfJugglers: patternConstraint.numberOfJugglers,
            period: patternConstraint.period,
            prechator: patternConstraint.prechator,
          ),
          [
            Throw(height: Fraction(7, 3), passingIndex: 1),
          ],
        );
      });

      test('calculates possible throws for fuzzy height', () {
        final constraint = ThrowConstraint.pass(height: 2.3);
        expect(
          engine.possibleThrows(
            throwConstraint: constraint,
            landingSite: 3,
            index: 2,
            numberOfJugglers: patternConstraint.numberOfJugglers,
            period: patternConstraint.period,
            prechator: patternConstraint.prechator,
          ),
          [
            Throw(height: Fraction(7, 3), passingIndex: 1),
          ],
        );
      });

      test('calculates possible throws for given passing index', () {
        const constraint = ThrowConstraint(height: null, passingIndex: 2);
        expect(
          engine.possibleThrows(
            throwConstraint: constraint,
            landingSite: 3,
            index: 2,
            numberOfJugglers: patternConstraint.numberOfJugglers,
            period: patternConstraint.period,
            prechator: patternConstraint.prechator,
          ),
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
            throwConstraint: constraint,
            landingSite: 2,
            index: 3,
            numberOfJugglers: patternConstraint.numberOfJugglers,
            period: patternConstraint.period,
            prechator: patternConstraint.prechator,
          ),
          [
            Throw(height: Fraction(5, 3), passingIndex: 2),
          ],
        );
      });

      test(
          'calculates possible throws for given passing index and fuzzy height',
          () {
        final constraint = ThrowConstraint.pass(height: 1.6, passingIndex: 2);
        expect(
          engine.possibleThrows(
            throwConstraint: constraint,
            landingSite: 2,
            index: 3,
            numberOfJugglers: patternConstraint.numberOfJugglers,
            period: patternConstraint.period,
            prechator: patternConstraint.prechator,
          ),
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
        patternConstraint = PatternConstraint(
          numberOfJugglers: 2,
          throwSequence: [
            ThrowConstraint.self(height: 4),
            ThrowConstraint.pass(height: null),
            ThrowConstraint.self(height: 1),
            ThrowConstraint.placeholder(),
          ],
        );

        engine = Engine(
          numberOfObjects: 4,
          maxHeight: 4,
          minNumberOfPasses: 0,
          maxNumberOfPasses: patternConstraint.period,
        );
      });

      test('finds correct patterns', () {
        expect(
          engine.fillConstraint(patternConstraint: patternConstraint),
          [
            Pattern(
              numberOfJugglers: 2,
              throwSequence: [
                Throw.self(height: 4),
                Throw.pass(height: 2),
                Throw.self(height: 1),
                Throw.pass(height: 1),
              ],
            ),
          ],
        );
      });

      test('calculates possible throws', () {
        final constraint = ThrowConstraint.placeholder();
        expect(
          engine.possibleThrows(
            throwConstraint: constraint,
            landingSite: 3,
            index: 2,
            numberOfJugglers: patternConstraint.numberOfJugglers,
            period: patternConstraint.period,
            prechator: patternConstraint.prechator,
          ),
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
            throwConstraint: constraint,
            landingSite: 3,
            index: 2,
            numberOfJugglers: patternConstraint.numberOfJugglers,
            period: patternConstraint.period,
            prechator: patternConstraint.prechator,
          ),
          [
            Throw.self(height: 1),
          ],
        );
      });

      test('calculates possible throws limited to passes', () {
        final constraint = ThrowConstraint(
          height: null,
          passingIndex: null,
          limitToPass: true,
        );
        expect(
          engine.possibleThrows(
            throwConstraint: constraint,
            landingSite: 3,
            index: 2,
            numberOfJugglers: patternConstraint.numberOfJugglers,
            period: patternConstraint.period,
            prechator: patternConstraint.prechator,
          ),
          [
            Throw.pass(height: 3),
          ],
        );
      });

      test('calculates possible throws for given passing index', () {
        const constraint = ThrowConstraint(height: null, passingIndex: 1);
        expect(
          engine.possibleThrows(
            throwConstraint: constraint,
            landingSite: 3,
            index: 2,
            numberOfJugglers: patternConstraint.numberOfJugglers,
            period: patternConstraint.period,
            prechator: patternConstraint.prechator,
          ),
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
            throwConstraint: constraint,
            landingSite: 2,
            index: 3,
            numberOfJugglers: patternConstraint.numberOfJugglers,
            period: patternConstraint.period,
            prechator: patternConstraint.prechator,
          ),
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
            throwConstraint: constraint,
            landingSite: 3,
            index: 3,
            numberOfJugglers: patternConstraint.numberOfJugglers,
            period: patternConstraint.period,
            prechator: patternConstraint.prechator,
          ),
          [],
        );
      });

      test('returns empty list as possible throws for invalid passing index',
          () {
        final constraint =
            ThrowConstraint(height: Fraction(1), passingIndex: 0);
        expect(
          engine.possibleThrows(
            throwConstraint: constraint,
            landingSite: 2,
            index: 3,
            numberOfJugglers: patternConstraint.numberOfJugglers,
            period: patternConstraint.period,
            prechator: patternConstraint.prechator,
          ),
          [],
        );
      });
    });
  });
}
