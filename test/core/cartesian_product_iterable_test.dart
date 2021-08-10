// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/core/cartesian_product_iterable.dart';
import 'package:test/test.dart';

void main() {
  group('CartesianProductIterable', () {
    test('calculates cartesian product', () {
      final iterable = CartesianProductIterable<int?>([
        [1, null, 3],
        [4],
        [5, 6],
      ]);
      expect(
        iterable.toList(),
        [
          [1, 4, 5],
          [1, 4, 6],
          [null, 4, 5],
          [null, 4, 6],
          [3, 4, 5],
          [3, 4, 6],
        ],
      );
    });

    test('does not fail with empty list', () {
      final iterable = CartesianProductIterable<int>([
        [1, 2, 3],
        [],
        [5, 6],
      ]);
      expect(
        iterable.toList(),
        <int>[],
      );
    });

    test('does not fail with no lists', () {
      final iterable = CartesianProductIterable<int>([]);
      expect(
        iterable.toList(),
        <int>[],
      );
    });
  });
}
