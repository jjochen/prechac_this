import 'package:fraction/fraction.dart';
import 'package:pattern_repository/pattern_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pattern_repository/src/engine/engine.dart';

void main() {
  group('Engine', () {
    group('4 1.3p1 _ 1.6p2', () {
      late Engine engine;
      setUp(() {
        engine = Engine(
          numberOfJugglers: 3,
          period: 4,
          numberOfObjects: 4,
          maxHeight: 4,
        );
      });

      test('calculates possible throws', () {
        final constraints = ThrowConstraints.placeholder();
        expect(
          engine.possibleThrows(
              throwConstraints: constraints, landingSite: 3, index: 2),
          [
            Throw(height: Fraction(5, 3), passingIndex: 2),
            Throw.self(height: 3),
          ],
        );
      });

      test('calculates possible throws for given height', () {
        final constraints =
            ThrowConstraints(height: Fraction(5, 3), passingIndex: null);
        expect(
          engine.possibleThrows(
              throwConstraints: constraints, landingSite: 2, index: 3),
          [
            Throw(height: Fraction(5, 3), passingIndex: 2),
          ],
        );
      });

      test('calculates possible throws for given passing index', () {
        final constraints = ThrowConstraints(height: null, passingIndex: 1);
        expect(
          engine.possibleThrows(
              throwConstraints: constraints, landingSite: 2, index: 3),
          [],
        );
      });

      test('calculates possible throws for given passing index and height', () {
        final constraints =
            ThrowConstraints(height: Fraction(5, 3), passingIndex: 2);
        expect(
          engine.possibleThrows(
              throwConstraints: constraints, landingSite: 2, index: 3),
          [
            Throw(height: Fraction(5, 3), passingIndex: 2),
          ],
        );
      });
    });

    group('4 _ 1 _', () {
      late PatternConstraints patternConstraints;
      late Engine engine;
      setUp(() {
        engine = Engine(
          numberOfJugglers: 2,
          period: 4,
          numberOfObjects: 4,
          maxHeight: 4,
        );
        patternConstraints = PatternConstraints([
          ThrowConstraints.self(height: 4),
          ThrowConstraints.placeholder(),
          ThrowConstraints.self(height: 1),
          ThrowConstraints.placeholder(),
        ]);
      });

      test('finds correct patterns', () async {
        await expectLater(
            engine.fillConstraints(patternConstraints: patternConstraints),
            emitsInOrder([
              [
                Pattern([
                  Throw.self(height: 4),
                  Throw.pass(height: 2),
                  Throw.self(height: 1),
                  Throw.pass(height: 1),
                ]),
              ]
            ]));
      });
    });
  });
}
