import 'package:pattern_repository/src/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pattern', () {
    test('supports value comparisons', () {
      expect(
        Pattern([
          Throw.self(height: 4),
          Throw.placeholder(),
          Throw(height: 4.5, passingIndex: 1),
        ]),
        Pattern([
          Throw.self(height: 4),
          Throw.placeholder(),
          Throw(height: 4.5, passingIndex: 1),
        ]),
      );
    });

    test('has correct string representation', () {
      expect(
        Pattern([
          Throw.self(height: 4),
          Throw.placeholder(),
          Throw(height: 4.5, passingIndex: 1),
        ]).toString(),
        '4, _, 4.5p1',
      );
    });

    test('throwAtIndex returns correct throw', () {
      final pattern = Pattern([
        Throw.self(height: 4),
        Throw.placeholder(),
        Throw(height: 4.5, passingIndex: 1),
      ]);
      expect(
        pattern.throwAtIndex(2),
        Throw(height: 4.5, passingIndex: 1),
      );
    });

    test('throws are iterable', () {
      final pattern = Pattern([
        Throw.self(height: 4),
        Throw.placeholder(),
        Throw(height: 4.5, passingIndex: 1),
      ]);
      final heights = pattern.map((element) => element.height).toList();
      expect(
        heights,
        [4, null, 4.5],
      );
    });
  });
}
