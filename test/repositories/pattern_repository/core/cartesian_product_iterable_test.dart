import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/repositories/pattern_repository/core/cartesian_product_iterable.dart';

void main() {
  group('CartesianProductIterable', () {
    late CartesianProductIterable iterable;
    setUp(() {
      iterable = CartesianProductIterable([
        [1, 2, 3],
        [4],
        [5, 6],
      ]);
    });

    test('calculates cartesian product', () {
      expect(
        iterable.toList(),
        [
          [1, 4, 5],
          [1, 4, 6],
          [2, 4, 5],
          [2, 4, 6],
          [3, 4, 5],
          [3, 4, 6],
        ],
      );
    });
  });
}
