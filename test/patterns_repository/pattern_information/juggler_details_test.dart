// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('JugglerDetails', () {
    late Pattern pattern;
    late JugglerDetails jugglerDetails;

    group('4 2p 1 1p', () {
      setUp(() {
        pattern = mockPattern;
      });

      group('juggler 0', () {
        setUp(() {
          jugglerDetails = JugglerDetails(jugglerIndex: 0, pattern: pattern);
        });

        test('localPattern', () {
          expect(
            jugglerDetails.localPattern,
            pattern,
          );
        });

        group('throwDetailsAtPointInTime', () {
          test('point in time 1', () {
            expect(
              jugglerDetails.throwDetailsAtPointInTime(Fraction(1)),
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
      });

      group('juggler 1', () {
        setUp(() {
          jugglerDetails = JugglerDetails(jugglerIndex: 1, pattern: pattern);
        });

        test('localPattern', () {
          expect(
            jugglerDetails.localPattern,
            Pattern(
              numberOfJugglers: 2,
              throwSequence: [
                Throw.self(height: 1),
                Throw.pass(height: 1),
                Throw.self(height: 4),
                Throw.pass(height: 2),
              ],
            ),
          );
        });

        group('throwDetailsAtPointInTime', () {
          test('point in time 0', () {
            expect(
              jugglerDetails.throwDetailsAtPointInTime(Fraction(0)),
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
              jugglerDetails.throwDetailsAtPointInTime(Fraction(6)),
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
    });
  });
}
