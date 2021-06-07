// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/engine/prechac_throw_constraint.dart';
import 'package:prechac_this/patterns_repository/models/throw_constraint.dart';
import 'package:test/test.dart';

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
