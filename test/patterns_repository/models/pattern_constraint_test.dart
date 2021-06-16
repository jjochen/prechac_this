// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/models/models.dart';
import 'package:test/test.dart';

void main() {
  group('PatternConstraint', () {
    test('supports value comparisons', () {
      expect(
        PatternConstraint(
          numberOfJugglers: 2,
          numberOfObjects: 4,
          maxHeight: 4,
          minNumberOfPasses: 0,
          maxNumberOfPasses: 4,
          throwSequence: [
            ThrowConstraint.self(height: 4),
            ThrowConstraint.placeholder(),
            ThrowConstraint.pass(height: 4.5),
          ],
        ),
        PatternConstraint(
          numberOfJugglers: 2,
          numberOfObjects: 4,
          maxHeight: 4,
          minNumberOfPasses: 0,
          maxNumberOfPasses: 4,
          throwSequence: [
            ThrowConstraint.self(height: 4),
            ThrowConstraint.placeholder(),
            ThrowConstraint.pass(height: 4.5),
          ],
        ),
      );
    });

    test('has correct string representation', () {
      expect(
        PatternConstraint(
          numberOfJugglers: 2,
          numberOfObjects: 4,
          maxHeight: 4,
          minNumberOfPasses: 0,
          maxNumberOfPasses: 4,
          throwSequence: [
            ThrowConstraint.self(height: 4),
            ThrowConstraint.placeholder(),
            ThrowConstraint.pass(height: 4.5),
          ],
        ).toString(),
        '4 _ 4.5p',
      );
    });

    test('rotates', () {
      expect(
        PatternConstraint(
          numberOfJugglers: 2,
          numberOfObjects: 4,
          maxHeight: 4,
          minNumberOfPasses: 0,
          maxNumberOfPasses: 4,
          throwSequence: [
            ThrowConstraint.self(height: null),
            ThrowConstraint(height: 4.toFraction(), passingIndex: null),
            ThrowConstraint.pass(height: 4.5),
          ],
        ).rotate(),
        PatternConstraint(
          numberOfJugglers: 2,
          numberOfObjects: 4,
          maxHeight: 4,
          minNumberOfPasses: 0,
          maxNumberOfPasses: 4,
          throwSequence: [
            ThrowConstraint(height: 4.toFraction(), passingIndex: null),
            ThrowConstraint.pass(height: 4.5),
            ThrowConstraint.self(height: null),
          ],
        ),
      );
    });

    test('throwAtIndex returns correct throw', () {
      final patternConstraint = PatternConstraint(
        numberOfJugglers: 2,
        numberOfObjects: 4,
        maxHeight: 4,
        minNumberOfPasses: 0,
        maxNumberOfPasses: 4,
        throwSequence: [
          ThrowConstraint.self(height: 4),
          ThrowConstraint.placeholder(),
          ThrowConstraint.pass(height: 4.5),
        ],
      );
      expect(
        patternConstraint.throwAtIndex(2),
        ThrowConstraint.pass(height: 4.5),
      );
    });

    test('throwConstraint are iterable', () {
      final patternConstraint = PatternConstraint(
        numberOfJugglers: 2,
        numberOfObjects: 4,
        maxHeight: 4,
        minNumberOfPasses: 0,
        maxNumberOfPasses: 4,
        throwSequence: [
          ThrowConstraint.self(height: 4),
          ThrowConstraint.placeholder(),
          ThrowConstraint.pass(height: 4.5),
        ],
      );
      final heights = patternConstraint
          .map((element) => element.height?.toDouble())
          .toList();
      expect(
        heights,
        [4, null, 4.5],
      );
    });
  });

  test('copyWith returns correct pattern', () {
    final patternConstraint = PatternConstraint(
      numberOfJugglers: 2,
      numberOfObjects: 4,
      maxHeight: 4,
      minNumberOfPasses: 0,
      maxNumberOfPasses: 4,
      throwSequence: [
        ThrowConstraint.self(height: 4),
        ThrowConstraint.placeholder(),
        ThrowConstraint.pass(height: 4.5),
      ],
    );

    expect(patternConstraint.copyWith(), patternConstraint);

    expect(
      patternConstraint.copyWith(
        numberOfJugglers: 3,
        numberOfObjects: 5,
        maxHeight: 6,
        minNumberOfPasses: 2,
        throwSequence: [
          ThrowConstraint.placeholder(),
          ThrowConstraint.self(height: 3),
          ThrowConstraint.pass(height: 4),
        ],
      ),
      PatternConstraint(
        numberOfJugglers: 3,
        numberOfObjects: 5,
        maxHeight: 6,
        minNumberOfPasses: 2,
        maxNumberOfPasses: 4,
        throwSequence: [
          ThrowConstraint.placeholder(),
          ThrowConstraint.self(height: 3),
          ThrowConstraint.pass(height: 4),
        ],
      ),
    );
  });

  test('copyWithThrow returns correct pattern', () {
    final patternConstraint = PatternConstraint(
      numberOfJugglers: 2,
      numberOfObjects: 4,
      maxHeight: 4,
      minNumberOfPasses: 0,
      maxNumberOfPasses: 4,
      throwSequence: [
        ThrowConstraint.self(height: 4),
        ThrowConstraint.placeholder(),
        ThrowConstraint.pass(height: 4.5),
      ],
    );
    expect(
      patternConstraint.copyWithThrow(
          newThrow: ThrowConstraint.self(height: 2), index: 1),
      PatternConstraint(
        numberOfJugglers: 2,
        numberOfObjects: 4,
        maxHeight: 4,
        minNumberOfPasses: 0,
        maxNumberOfPasses: 4,
        throwSequence: [
          ThrowConstraint.self(height: 4),
          ThrowConstraint.self(height: 2),
          ThrowConstraint.pass(height: 4.5),
        ],
      ),
    );
  });
}
