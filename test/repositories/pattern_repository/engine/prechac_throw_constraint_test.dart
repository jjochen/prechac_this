import 'package:flutter_test/flutter_test.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/repositories/pattern_repository/engine/prechac_throw_constraint.dart';
import 'package:prechac_this/repositories/pattern_repository/models/throw_constraint.dart';

void main() {
  group('PrechacThrowConstraint', () {
    test('calculates landing site for self', () {
      expect(
        ThrowConstraint.self(height: 4).landingSite(
          position: 0,
          period: 4,
          prechator: 2.toFraction(),
        ),
        0,
      );
    });

    test('calculates landing site for pass', () {
      expect(
        ThrowConstraint(height: Fraction(5, 3), passingIndex: 2).landingSite(
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
        () => ThrowConstraint(height: Fraction(5, 3), passingIndex: 1)
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
