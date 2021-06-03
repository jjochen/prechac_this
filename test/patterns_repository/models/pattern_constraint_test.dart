import 'package:flutter_test/flutter_test.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/models/models.dart';

void main() {
  group('PatternConstraint', () {
    test('supports value comparisons', () {
      expect(
        PatternConstraint([
          ThrowConstraint.self(height: 4),
          ThrowConstraint.placeholder(),
          ThrowConstraint.pass(height: 4.5),
        ]),
        PatternConstraint([
          ThrowConstraint.self(height: 4),
          ThrowConstraint.placeholder(),
          ThrowConstraint.pass(height: 4.5),
        ]),
      );
    });

    test('has correct string representation', () {
      expect(
        PatternConstraint([
          ThrowConstraint.self(height: 4),
          ThrowConstraint.placeholder(),
          ThrowConstraint.pass(height: 4.5),
        ]).toString(),
        '4, _, 4.5p1',
      );
    });

    test('rotates', () {
      expect(
        PatternConstraint([
          ThrowConstraint.self(height: null),
          ThrowConstraint(height: 4.toFraction(), passingIndex: null),
          ThrowConstraint.pass(height: 4.5),
        ]).rotate(),
        PatternConstraint([
          ThrowConstraint(height: 4.toFraction(), passingIndex: null),
          ThrowConstraint.pass(height: 4.5),
          ThrowConstraint.self(height: null),
        ]),
      );
    });

    test('throwAtIndex returns correct throw', () {
      final patternConstraint = PatternConstraint([
        ThrowConstraint.self(height: 4),
        ThrowConstraint.placeholder(),
        ThrowConstraint.pass(height: 4.5),
      ]);
      expect(
        patternConstraint.throwAtIndex(2),
        ThrowConstraint.pass(height: 4.5),
      );
    });

    test('throwConstraint are iterable', () {
      final patternConstraint = PatternConstraint([
        ThrowConstraint.self(height: 4),
        ThrowConstraint.placeholder(),
        ThrowConstraint.pass(height: 4.5),
      ]);
      final heights = patternConstraint
          .map((element) => element.height?.toDouble())
          .toList();
      expect(
        heights,
        [4, null, 4.5],
      );
    });
  });

  test('copyWithThrow returns correct pattern', () {
    final patternConstraint = PatternConstraint([
      ThrowConstraint.self(height: 4),
      ThrowConstraint.placeholder(),
      ThrowConstraint.pass(height: 4.5),
    ]);
    expect(
      patternConstraint.copyWithThrow(
          newThrow: ThrowConstraint.self(height: 2), index: 1),
      PatternConstraint([
        ThrowConstraint.self(height: 4),
        ThrowConstraint.self(height: 2),
        ThrowConstraint.pass(height: 4.5),
      ]),
    );
  });
}
