import 'package:flutter_test/flutter_test.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/models/models.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Pattern', () {
    test('supports comparison of length', () {
      expect(
        Pattern([
              Throw.self(height: 4),
            ]) <
            Pattern([
              Throw.self(height: 4),
              Throw.pass(height: 4.5),
            ]),
        isTrue,
      );
    });

    test('supports comparison of throws', () {
      expect(
        Pattern([
              Throw.self(height: 4),
              Throw.pass(height: 4.5),
            ]) <
            Pattern([
              Throw.pass(height: 4.5),
              Throw.self(height: 4),
            ]),
        isTrue,
      );
    });

    test('supports value comparisons', () {
      expect(
        Pattern([
          Throw.self(height: 4),
          Throw(height: 4.toFraction(), passingIndex: 3),
          Throw.pass(height: 4.5),
        ]),
        Pattern([
          Throw.self(height: 4),
          Throw(height: 4.toFraction(), passingIndex: 3),
          Throw.pass(height: 4.5),
        ]),
      );
    });

    test('from valid ID', () {
      expect(
        Pattern.fromId('4-1-0_2-1-1_1-1-0_1-1-1'),
        mockPattern,
      );
    });

    test('from invalid ID is null', () {
      expect(
        Pattern.fromId('4-1-0_2-1-1_1-1-0_1-1-x'),
        isNull,
      );
    });

    test('supports representation as ID', () {
      expect(
        Pattern.fromId(mockPattern.id),
        mockPattern,
      );
    });

    test('set of patterns does not contain duplicates', () {
      final set = <Pattern>{}
        ..add(Pattern([Throw.pass(height: 3), Throw.pass(height: 1)]))
        ..add(Pattern([Throw.pass(height: 3), Throw.pass(height: 1)]));
      expect(
        set,
        {
          Pattern([Throw.pass(height: 3), Throw.pass(height: 1)]),
        },
      );
    });

    test('rotates', () {
      expect(
        Pattern([
          Throw.self(height: 4),
          Throw(height: 4.toFraction(), passingIndex: 3),
          Throw.pass(height: 4.5),
        ]).rotate(),
        Pattern([
          Throw(height: 4.toFraction(), passingIndex: 3),
          Throw.pass(height: 4.5),
          Throw.self(height: 4),
        ]),
      );
    });

    test('allRotations returns list with all rotations', () {
      expect(
          Pattern([
            Throw.self(height: 4),
            Throw(height: 4.toFraction(), passingIndex: 3),
            Throw.pass(height: 4.5),
          ]).allRotations(),
          [
            Pattern([
              Throw.self(height: 4),
              Throw(height: 4.toFraction(), passingIndex: 3),
              Throw.pass(height: 4.5),
            ]),
            Pattern([
              Throw(height: 4.toFraction(), passingIndex: 3),
              Throw.pass(height: 4.5),
              Throw.self(height: 4),
            ]),
            Pattern([
              Throw.pass(height: 4.5),
              Throw.self(height: 4),
              Throw(height: 4.toFraction(), passingIndex: 3),
            ]),
          ]);
    });

    test('normalize rotates highest throw first', () {
      expect(
        Pattern([
          Throw.self(height: 4),
          Throw(height: 4.toFraction(), passingIndex: 3),
          Throw.pass(height: 4.5),
        ]).normalize(),
        Pattern([
          Throw.pass(height: 4.5),
          Throw.self(height: 4),
          Throw(height: 4.toFraction(), passingIndex: 3),
        ]),
      );
    });

    test('has correct string representation', () {
      expect(
        Pattern([
          Throw.self(height: 4),
          Throw(height: 4.toFraction(), passingIndex: 3),
          Throw.pass(height: 4.5),
        ]).toString(),
        '4, 4p3, 4.5p1',
      );
    });

    test('throwAtIndex returns correct throw', () {
      final pattern = Pattern([
        Throw.self(height: 4),
        Throw(height: 4.toFraction(), passingIndex: 3),
        Throw.pass(height: 4.5),
      ]);
      expect(
        pattern.throwAtIndex(2),
        Throw.pass(height: 4.5),
      );
    });

    test('throw are iterable', () {
      final pattern = Pattern([
        Throw.self(height: 4),
        Throw(height: 4.toFraction(), passingIndex: 3),
        Throw.pass(height: 4.5),
      ]);
      final heights =
          pattern.map((element) => element.height.toDouble()).toList();
      expect(
        heights,
        [4, 4, 4.5],
      );
    });

    test('copyWithThrow returns correct pattern', () {
      final pattern = Pattern([
        Throw.self(height: 4),
        Throw(height: 4.toFraction(), passingIndex: 3),
        Throw.pass(height: 4.5),
      ]);
      expect(
        pattern.copyWithThrow(newThrow: Throw.self(height: 2), index: 1),
        Pattern([
          Throw.self(height: 4),
          Throw.self(height: 2),
          Throw.pass(height: 4.5),
        ]),
      );
    });

    test('number of passes calculated correctly', () {
      final pattern = Pattern([
        Throw.self(height: 4),
        Throw(height: 4.toFraction(), passingIndex: 3),
        Throw.pass(height: 4.5),
      ]);
      expect(
        pattern.numberOfPasses(),
        2,
      );
    });

    test('average number of objects calculated correctly', () {
      final pattern = Pattern([
        Throw.self(height: 4),
        Throw(height: (3.5).toFraction(), passingIndex: 3),
        Throw.pass(height: 4.5),
      ]);
      expect(
        pattern.averageNumberOfObjectsPerJuggler(),
        4.toFraction(),
      );
    });
  });
}
