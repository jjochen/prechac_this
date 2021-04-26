import 'package:pattern_repository/src/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PatternConstraints', () {
    test('supports value comparisons', () {
      expect(
        PatternConstraints([
          ThrowConstraints.self(height: 4),
          ThrowConstraints.placeholder(),
          ThrowConstraints.pass(height: 4.5),
        ]),
        PatternConstraints([
          ThrowConstraints.self(height: 4),
          ThrowConstraints.placeholder(),
          ThrowConstraints.pass(height: 4.5),
        ]),
      );
    });

    test('has correct string representation', () {
      expect(
        PatternConstraints([
          ThrowConstraints.self(height: 4),
          ThrowConstraints.placeholder(),
          ThrowConstraints.pass(height: 4.5),
        ]).toString(),
        '4, _, 4.5p1',
      );
    });

    test('throwConstraintsAtIndex returns correct throw', () {
      final patternConstraints = PatternConstraints([
        ThrowConstraints.self(height: 4),
        ThrowConstraints.placeholder(),
        ThrowConstraints.pass(height: 4.5),
      ]);
      expect(
        patternConstraints.throwConstraintsAtIndex(2),
        ThrowConstraints.pass(height: 4.5),
      );
    });

    test('throwConstraints are iterable', () {
      final patternConstraints = PatternConstraints([
        ThrowConstraints.self(height: 4),
        ThrowConstraints.placeholder(),
        ThrowConstraints.pass(height: 4.5),
      ]);
      final heights = patternConstraints
          .map((element) => element.height?.toDouble())
          .toList();
      expect(
        heights,
        [4, null, 4.5],
      );
    });
  });

  test('copyWithThrowConstraints returns correct pattern', () {
    final patternConstraints = PatternConstraints([
      ThrowConstraints.self(height: 4),
      ThrowConstraints.placeholder(),
      ThrowConstraints.pass(height: 4.5),
    ]);
    expect(
      patternConstraints.copyWithThrowConstraints(
          newThrowConstraints: ThrowConstraints.self(height: 2), index: 1),
      PatternConstraints([
        ThrowConstraints.self(height: 4),
        ThrowConstraints.self(height: 2),
        ThrowConstraints.pass(height: 4.5),
      ]),
    );
  });
}
