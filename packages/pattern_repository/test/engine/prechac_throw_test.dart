import 'package:flutter_test/flutter_test.dart';
import 'package:fraction/fraction.dart';

import 'package:pattern_repository/src/models/throw.dart';
import 'package:pattern_repository/src/engine/prechac_throw.dart';

void main() {
  group('PrechacThrow', () {
    test('calculates landing site for self', () {
      expect(
        Throw.self(height: 4).landingSite(
          position: 0,
          period: 4,
          prechator: 2.toFraction(),
        ),
        0,
      );
    });

    test('calculates landing site for pass', () {
      expect(
        Throw(height: Fraction(5, 3), passingIndex: 2).landingSite(
          position: 4,
          period: 4,
          prechator: Fraction(4, 3),
        ),
        3,
      );
    });

    test('throws an error when calculating landing site with invalid throw',
        () {
      expect(
        () => Throw(height: Fraction(5, 3), passingIndex: 1).landingSite(
          position: 4,
          period: 4,
          prechator: Fraction(4, 3),
        ),
        throwsException,
      );
    });

    test('throws an error when calculating landing site with invalid throw',
        () {
      expect(
        () => Throw(height: Fraction(5, 3), passingIndex: 1).landingSite(
          position: 4,
          period: 4,
          prechator: Fraction(4, 3),
        ),
        throwsException,
      );
    });
  });
}
