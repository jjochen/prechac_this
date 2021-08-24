// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

void main() {
  group('ThrowDetails', () {
    test('supports value comparisons', () {
      expect(
        ThrowDetails(
          pointInTime: Fraction(1, 2),
          throwingJuggler: 1,
          throwingSiteswapPosition: 3,
          theThrow: Throw.pass(height: 4),
          landingTime: Fraction(3),
          catchingJuggler: 0,
          numberOfObjectsThrown: 1,
        ),
        ThrowDetails(
          pointInTime: Fraction(1, 2),
          throwingJuggler: 1,
          throwingSiteswapPosition: 3,
          theThrow: Throw.pass(height: 4),
          landingTime: Fraction(3),
          catchingJuggler: 0,
          numberOfObjectsThrown: 1,
        ),
      );
    });

    test('isStartingHand', () {
      expect(
        ThrowDetails(
          pointInTime: 5.toFraction(),
          throwingJuggler: 1,
          throwingSiteswapPosition: 3,
          theThrow: Throw.pass(height: 1),
          landingTime: 6.toFraction(),
          catchingJuggler: 0,
          numberOfObjectsThrown: 1,
        ).isStartingHand,
        isFalse,
      );
    });
  });
}
