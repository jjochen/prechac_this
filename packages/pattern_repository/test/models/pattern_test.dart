import 'package:pattern_repository/src/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pattern', () {
    test('supports value comparisons', () {
      expect(
        Pattern([
          Throw.self(height: 4),
          Throw.placeholder(),
          Throw.pass(height: 4.5),
        ]),
        Pattern([
          Throw.self(height: 4),
          Throw.placeholder(),
          Throw.pass(height: 4.5),
        ]),
      );
    });

    test('has correct string representation', () {
      expect(
        Pattern([
          Throw.self(height: 4),
          Throw.placeholder(),
          Throw.pass(height: 4.5),
        ]).toString(),
        '4, _, 4.5p1',
      );
    });

    test('throwAtIndex returns correct throw', () {
      final pattern = Pattern([
        Throw.self(height: 4),
        Throw.placeholder(),
        Throw.pass(height: 4.5),
      ]);
      expect(
        pattern.throwAtIndex(2),
        Throw.pass(height: 4.5),
      );
    });

    test('throws are iterable', () {
      final pattern = Pattern([
        Throw.self(height: 4),
        Throw.placeholder(),
        Throw.pass(height: 4.5),
      ]);
      final heights =
          pattern.map((element) => element.height?.toDouble()).toList();
      expect(
        heights,
        [4, null, 4.5],
      );
    });
  });

  test('copyWithThrow returns correct pattern', () {
    final pattern = Pattern([
      Throw.self(height: 4),
      Throw.placeholder(),
      Throw.pass(height: 4.5),
    ]);
    expect(
      pattern.copyWithThow(newThrow: Throw.self(height: 2), index: 1),
      Pattern([
        Throw.self(height: 4),
        Throw.self(height: 2),
        Throw.pass(height: 4.5),
      ]),
    );
  });
}
