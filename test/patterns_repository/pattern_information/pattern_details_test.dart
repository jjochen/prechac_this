// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PatternDetails', () {
    late PatternDetails patternDetails;

    group('4 2p 1 1p', () {
      setUp(() {
        patternDetails = PatternDetails(pattern: mockPattern);
      });

      test('pointsInTime', () {
        expect(
          patternDetails.pointsInTime(),
          [
            0.toFraction(),
            1.toFraction(),
            2.toFraction(),
            3.toFraction(),
          ],
        );
      });

      group('throwDetailsAtPointInTime', () {
        group('juggler 0', () {
          test('point in time 1', () {
            expect(
              patternDetails
                  .infoForJuggler(0)
                  .throwDetailsAtPointInTime(Fraction(1)),
              ThrowDetails(
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
              patternDetails
                  .infoForJuggler(1)
                  .throwDetailsAtPointInTime(Fraction(0)),
              ThrowDetails(
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

          test('point in time 6', () {
            expect(
              patternDetails
                  .infoForJuggler(1)
                  .throwDetailsAtPointInTime(Fraction(6)),
              ThrowDetails(
                pointInTime: 6.toFraction(),
                throwingJuggler: 1,
                throwingSiteswapPosition: 0,
                theThrow: Throw.self(height: 4),
                landingTime: 10.toFraction(),
                catchingJuggler: 1,
                numberOfObjectsThrown: 1,
              ),
            );
          });
        });
      });

      test('numberOfObjectsInHands', () {
        final juggler0 = patternDetails.infoForJuggler(0)
          ..startingHand = Hand.right;
        final juggler1 = patternDetails.infoForJuggler(1)
          ..startingHand = Hand.left;
        expect(juggler0.numberOfObjectsInHand(Hand.right), 1);
        expect(juggler0.numberOfObjectsInHand(Hand.left), 1);
        expect(juggler1.numberOfObjectsInHand(Hand.right), 0);
        expect(juggler1.numberOfObjectsInHand(Hand.left), 2);
      });

      test('throwDirectionAtPointInTime', () {
        expect(
          patternDetails.throwDirectionAtPointInTime(
            juggler: 0,
            pointInTime: Fraction(1),
          ),
          ThrowDirection.cross,
        );
        expect(
          patternDetails.throwDirectionAtPointInTime(
            juggler: 1,
            pointInTime: Fraction(2),
          ),
          ThrowDirection.self,
        );
        expect(
          patternDetails.throwDirectionAtPointInTime(
            juggler: 1,
            pointInTime: Fraction(1),
          ),
          ThrowDirection.tramline,
        );
      });
    });

    group('2.5p 2.5p 2 1.5p 1.5p', () {
      setUp(() {
        patternDetails = PatternDetails(
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
          patternDetails.pointsInTime(),
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
        final juggler0 = patternDetails.infoForJuggler(0)
          ..startingHand = Hand.right;
        final juggler1 = patternDetails.infoForJuggler(1)
          ..startingHand = Hand.left;
        expect(juggler0.numberOfObjectsInHand(Hand.right), 1);
        expect(juggler0.numberOfObjectsInHand(Hand.left), 1);
        expect(juggler1.numberOfObjectsInHand(Hand.right), 1);
        expect(juggler1.numberOfObjectsInHand(Hand.left), 1);
      });

      test('throwingHandAtPointInTime', () {
        final juggler1 = patternDetails.infoForJuggler(1);
        expect(
          juggler1.throwingHandAtPointInTime(3.5.toFraction()),
          Hand.left,
        );
        juggler1.toggleStartingHand();
        expect(
          juggler1.throwingHandAtPointInTime(3.5.toFraction()),
          Hand.right,
        );

        final juggler0 = patternDetails.infoForJuggler(0);
        expect(
          juggler0.throwingHandAtPointInTime(3.5.toFraction()),
          isNull,
        );
      });
    });

    group('3.3p2 2.6p1 2.3p2 1.6p1 1.6p1', () {
      setUp(() {
        patternDetails = PatternDetails(
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
          patternDetails.pointsInTime(),
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
        patternDetails = PatternDetails(
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
          patternDetails.pointsInTime(),
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

    group('0 3p2 1.5p1 1 2p2 3p2', () {
      setUp(() {
        patternDetails = PatternDetails(
            pattern: Pattern(
          numberOfJugglers: 4,
          throwSequence: [
            Throw(height: Fraction(0, 2), passingIndex: 0),
            Throw(height: Fraction(6, 2), passingIndex: 2),
            Throw(height: Fraction(3, 2), passingIndex: 1),
            Throw(height: Fraction(2, 2), passingIndex: 0),
            Throw(height: Fraction(4, 2), passingIndex: 2),
            Throw(height: Fraction(6, 2), passingIndex: 2),
          ],
        ));
      });

      test('pointsInTime', () {
        expect(
          patternDetails.pointsInTime(),
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

      group('JugglerDetails', () {
        late JugglerDetails jugglerDetails;

        group('juggler 0', () {
          setUp(() {
            jugglerDetails = patternDetails.infoForJuggler(0);
          });

          test('numberOfObjectsInHand', () {
            expect(jugglerDetails.numberOfObjectsInHand(Hand.right), 0);
            expect(jugglerDetails.numberOfObjectsInHand(Hand.left), 1);
          });

          test('throwDetailsAtPointInTime', () {
            expect(
              jugglerDetails
                  .throwDetailsAtPointInTime(Fraction(0))!
                  .theThrow
                  .toString(),
              '0',
            );
            expect(
              jugglerDetails
                  .throwDetailsAtPointInTime(Fraction(1))!
                  .theThrow
                  .toString(),
              '3p₂',
            );
            expect(
              jugglerDetails
                  .throwDetailsAtPointInTime(Fraction(2))!
                  .theThrow
                  .toString(),
              '1.5p₁',
            );
            expect(
              jugglerDetails
                  .throwDetailsAtPointInTime(Fraction(3))!
                  .theThrow
                  .toString(),
              '1',
            );
            expect(
              jugglerDetails
                  .throwDetailsAtPointInTime(Fraction(4))!
                  .theThrow
                  .toString(),
              '2p₂',
            );
            expect(
              jugglerDetails
                  .throwDetailsAtPointInTime(Fraction(5))!
                  .theThrow
                  .toString(),
              '3p₂',
            );
          });
        });

        group('juggler 1', () {
          setUp(() {
            jugglerDetails = patternDetails.infoForJuggler(1);
          });

          test('numberOfObjectsInHand', () {
            expect(jugglerDetails.numberOfObjectsInHand(Hand.right), 2);
            expect(jugglerDetails.numberOfObjectsInHand(Hand.left), 0);
          });
        });

        group('juggler 2', () {
          setUp(() {
            jugglerDetails = patternDetails.infoForJuggler(2);
          });

          test('numberOfObjectsInHand', () {
            expect(jugglerDetails.numberOfObjectsInHand(Hand.right), 2);
            expect(jugglerDetails.numberOfObjectsInHand(Hand.left), 0);
          });
        });

        group('juggler 3', () {
          setUp(() {
            jugglerDetails = patternDetails.infoForJuggler(3);
          });

          test('numberOfObjectsInHand', () {
            expect(jugglerDetails.numberOfObjectsInHand(Hand.right), 1);
            expect(jugglerDetails.numberOfObjectsInHand(Hand.left), 1);
          });
        });
      });
    });
  });
}
