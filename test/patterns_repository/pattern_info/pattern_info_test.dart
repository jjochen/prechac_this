// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PatternInfo', () {
    group('pointsInTime', () {
      test('4 2p 1 1p', () {
        expect(
          PatternInfo(pattern: mockPattern).pointsInTime(),
          [
            0.toFraction(),
            1.toFraction(),
            2.toFraction(),
            3.toFraction(),
          ],
        );
      });

      test('2.5p 2.5p 2 1.5p 1.5p', () {
        final pattern = Pattern(
          numberOfJugglers: 2,
          throwSequence: [
            Throw.pass(height: 2.5),
            Throw.pass(height: 2.5),
            Throw.self(height: 2),
            Throw.pass(height: 1.5),
            Throw.pass(height: 1.5),
          ],
        );
        expect(
          PatternInfo(pattern: pattern).pointsInTime(),
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

      test('3.3p2 2.6p1 2.3p2 1.6p1 1.6p1', () {
        final pattern = Pattern(
          numberOfJugglers: 3,
          throwSequence: [
            Throw(height: Fraction(10, 3), passingIndex: 2),
            Throw(height: Fraction(8, 3), passingIndex: 1),
            Throw(height: Fraction(7, 3), passingIndex: 2),
            Throw(height: Fraction(5, 3), passingIndex: 1),
            Throw(height: Fraction(5, 3), passingIndex: 1),
          ],
        );
        expect(
          PatternInfo(pattern: pattern).pointsInTime(),
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

      test('2.5p3 1.5p1 1 2p2 1 1', () {
        final pattern = Pattern(
          numberOfJugglers: 4,
          throwSequence: [
            Throw(height: Fraction(5, 2), passingIndex: 3),
            Throw(height: Fraction(3, 2), passingIndex: 1),
            Throw(height: Fraction(2, 2), passingIndex: 0),
            Throw(height: Fraction(4, 2), passingIndex: 2),
            Throw(height: Fraction(2, 2), passingIndex: 0),
            Throw(height: Fraction(2, 2), passingIndex: 0),
          ],
        );
        expect(
          PatternInfo(pattern: pattern).pointsInTime(),
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
