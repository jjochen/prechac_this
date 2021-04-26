import 'package:flutter_test/flutter_test.dart';
import 'package:fraction/fraction.dart';

import 'package:pattern_repository/src/models/throw_constraints.dart';
import 'package:pattern_repository/src/engine/prechac_throw_constraints.dart';

void main() {
  group('PrechacThrowConstraints', () {
    test('calculates landing site for self', () {
      expect(
        ThrowConstraints.self(height: 4).landingSite(
          position: 0,
          period: 4,
          prechator: 2.toFraction(),
        ),
        0,
      );
    });

    test('calculates landing site for pass', () {
      expect(
        ThrowConstraints(height: Fraction(5, 3), passingIndex: 2).landingSite(
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
        () => ThrowConstraints(height: Fraction(5, 3), passingIndex: 1)
            .landingSite(
          position: 4,
          period: 4,
          prechator: Fraction(4, 3),
        ),
        throwsException,
      );
    });
  });
}
