// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PatternInfo', () {
    late PatternInfo patternInfo;

    group('4 2p 1 1p', () {
      setUp(() {
        patternInfo = PatternInfo(pattern: mockPattern);
      });

      test('pointsInTime', () {
        expect(
          patternInfo.pointsInTime(),
          [
            0.toFraction(),
            1.toFraction(),
            2.toFraction(),
            3.toFraction(),
          ],
        );
      });

      group('juggersThrowInfoAtPointInTime', () {
        group('juggler 0', () {
          test('point in time 1', () {
            expect(
              patternInfo.juggersThrowInfoAtPointInTime(
                juggler: 0,
                pointInTime: Fraction(1),
              ),
              ThrowInfo(
                pointInTime: 1.toFraction(),
                throwingJuggler: 0,
                throwingSiteswapPosition: 1,
                theThrow: Throw.pass(height: 2),
                landingTime: 3.toFraction(),
                catchingJuggler: 1,
                numberOfObjectsThrown: 1,
              ),
            );
          });
        });

        group('juggler 1', () {
          test('point in time 0', () {
            expect(
              patternInfo.juggersThrowInfoAtPointInTime(
                juggler: 1,
                pointInTime: Fraction(0),
              ),
              ThrowInfo(
                pointInTime: 0.toFraction(),
                throwingJuggler: 1,
                throwingSiteswapPosition: 2,
                theThrow: Throw.self(height: 1),
                landingTime: 1.toFraction(),
                catchingJuggler: 1,
                numberOfObjectsThrown: 1,
              ),
            );
          });

          test('point in time 5', () {
            expect(
              patternInfo.juggersThrowInfoAtPointInTime(
                juggler: 1,
                pointInTime: Fraction(5),
              ),
              ThrowInfo(
                pointInTime: 5.toFraction(),
                throwingJuggler: 1,
                throwingSiteswapPosition: 3,
                theThrow: Throw.pass(height: 1),
                landingTime: 6.toFraction(),
                catchingJuggler: 0,
                numberOfObjectsThrown: 1,
              ),
            );
          });
        });
      });

      test('numberOfObjectsInHands', () {
        expect(
          patternInfo.numberOfObjectsInHands(),
          [
            [1, 1],
            [2, 0],
          ],
        );
      });
    });

    group('2.5p 2.5p 2 1.5p 1.5p', () {
      setUp(() {
        patternInfo = PatternInfo(
            pattern: Pattern(
          numberOfJugglers: 2,
          throwSequence: [
            Throw.pass(height: 2.5),
            Throw.pass(height: 2.5),
            Throw.self(height: 2),
            Throw.pass(height: 1.5),
            Throw.pass(height: 1.5),
          ],
        ));
      });

      test('pointsInTime', () {
        expect(
          patternInfo.pointsInTime(),
          [
            0.toFraction(),
            0.5.toFraction(),
            1.toFraction(),
            1.5.toFraction(),
            2.toFraction(),
            2.5.toFraction(),
            3.toFraction(),
            3.5.toFraction(),
            4.toFraction(),
            4.5.toFraction(),
          ],
        );
      });

      test('numberOfObjectsInHands', () {
        expect(
          patternInfo.numberOfObjectsInHands(),
          [
            [1, 1],
            [1, 1],
          ],
        );
      });
    });

    group('3.3p2 2.6p1 2.3p2 1.6p1 1.6p1', () {
      setUp(() {
        patternInfo = PatternInfo(
            pattern: Pattern(
          numberOfJugglers: 3,
          throwSequence: [
            Throw(height: Fraction(10, 3), passingIndex: 2),
            Throw(height: Fraction(8, 3), passingIndex: 1),
            Throw(height: Fraction(7, 3), passingIndex: 2),
            Throw(height: Fraction(5, 3), passingIndex: 1),
            Throw(height: Fraction(5, 3), passingIndex: 1),
          ],
        ));
      });

      test('pointsInTime', () {
        expect(
          patternInfo.pointsInTime(),
          [
            Fraction(0, 3),
            Fraction(1, 3),
            Fraction(2, 3),
            Fraction(3, 3),
            Fraction(4, 3),
            Fraction(5, 3),
            Fraction(6, 3),
            Fraction(7, 3),
            Fraction(8, 3),
            Fraction(9, 3),
            Fraction(10, 3),
            Fraction(11, 3),
            Fraction(12, 3),
            Fraction(13, 3),
            Fraction(14, 3),
          ],
        );
      });
    });
    group('2.5p3 1.5p1 1 2p2 1 1', () {
      setUp(() {
        patternInfo = PatternInfo(
            pattern: Pattern(
          numberOfJugglers: 4,
          throwSequence: [
            Throw(height: Fraction(5, 2), passingIndex: 3),
            Throw(height: Fraction(3, 2), passingIndex: 1),
            Throw(height: Fraction(2, 2), passingIndex: 0),
            Throw(height: Fraction(4, 2), passingIndex: 2),
            Throw(height: Fraction(2, 2), passingIndex: 0),
            Throw(height: Fraction(2, 2), passingIndex: 0),
          ],
        ));
      });

      test('pointsInTime', () {
        expect(
          patternInfo.pointsInTime(),
          [
            Fraction(0, 2),
            Fraction(1, 2),
            Fraction(2, 2),
            Fraction(3, 2),
            Fraction(4, 2),
            Fraction(5, 2),
            Fraction(6, 2),
            Fraction(7, 2),
            Fraction(8, 2),
            Fraction(9, 2),
            Fraction(10, 2),
            Fraction(11, 2),
          ],
        );
      });
    });
  });
}
