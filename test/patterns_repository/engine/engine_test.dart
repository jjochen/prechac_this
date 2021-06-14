// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/engine/engine.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

void main() {
  group('Engine', () {
    late Engine engine;
    setUp(() {
      engine = Engine();
    });

    group('4 1.3p_ _ 1.6p2', () {
      late PatternConstraint patternConstraint;
      setUp(() {
        patternConstraint = PatternConstraint(
          numberOfJugglers: 3,
          numberOfObjects: 6,
          maxHeight: 4,
          minNumberOfPasses: 1,
          maxNumberOfPasses: 4,
          throwSequence: [
            ThrowConstraint.self(height: 4),
            ThrowConstraint.pass(height: 1.3),
            ThrowConstraint.placeholder(),
            ThrowConstraint(height: Fraction(5, 3), passingIndex: 2),
          ],
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
            ThrowConstraint.pass(height: null),
            ThrowConstraint.self(height: 1),
            ThrowConstraint.placeholder(),
          ],
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
    });
  });
}
