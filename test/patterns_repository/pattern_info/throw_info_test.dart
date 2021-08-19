// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('ThrowInfo', () {
    test('supports value comparisons', () {
      expect(
        ThrowInfo(
          pointInTime: Fraction(1, 2),
          throwingJuggler: 1,
          throwingSiteswapPosition: 3,
          theThrow: Throw.pass(height: 4),
          landingTime: Fraction(3),
          catchingJuggler: 0,
          numberOfThrownObjects: 1,
        ),
        ThrowInfo(
          pointInTime: Fraction(1, 2),
          throwingJuggler: 1,
          throwingSiteswapPosition: 3,
          theThrow: Throw.pass(height: 4),
          landingTime: Fraction(3),
          catchingJuggler: 0,
          numberOfThrownObjects: 1,
        ),
      );
    });

    group('4 2p 1 1p', () {
      late Pattern pattern;
      setUp(() {
        pattern = mockPattern;
      });

      test('juggler 0 - index 0', () {
        expect(
          ThrowInfo.fromPattern(pattern: pattern, juggler: 0, index: 0),
          ThrowInfo(
            pointInTime: 0.toFraction(),
            throwingJuggler: 0,
            throwingSiteswapPosition: 0,
            theThrow: Throw.self(height: 4),
            landingTime: 4.toFraction(),
            catchingJuggler: 0,
            numberOfThrownObjects: 1,
          ),
        );
      });

      test('juggler 1 - index 0', () {
        expect(
          ThrowInfo.fromPattern(pattern: pattern, juggler: 1, index: 0),
          ThrowInfo(
            pointInTime: 0.toFraction(),
            throwingJuggler: 1,
            throwingSiteswapPosition: 3,
            theThrow: Throw.self(height: 1),
            landingTime: 1.toFraction(),
            catchingJuggler: 1,
            numberOfThrownObjects: 1,
          ),
        );
      });
    });
  });
}
