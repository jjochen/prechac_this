// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:dartx/dartx.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/models/models.dart';
import 'package:test/test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Pattern', () {
    test('supports comparison of number of jugglers', () {
      expect(
        Pattern(
              numberOfJugglers: 2,
              throwSequence: [
                Throw.self(height: 4),
              ],
            ) <
            Pattern(
              numberOfJugglers: 3,
              throwSequence: [
                Throw.self(height: 4),
              ],
            ),
        isTrue,
      );
    });

    test('supports comparison of length', () {
      expect(
        Pattern(
              numberOfJugglers: 2,
              throwSequence: [
                Throw.self(height: 4),
              ],
            ) <
            Pattern(
              numberOfJugglers: 2,
              throwSequence: [
                Throw.self(height: 4),
                Throw.pass(height: 3),
              ],
            ),
        isTrue,
      );
    });

    test('supports comparison of throws', () {
      expect(
        Pattern(
              numberOfJugglers: 2,
              throwSequence: [
                Throw.self(height: 3),
                Throw.pass(height: 1),
                Throw.pass(height: 1),
                Throw.self(height: 3),
              ],
            ) <
            Pattern(
              numberOfJugglers: 2,
              throwSequence: [
                Throw.self(height: 3),
                Throw.self(height: 3),
                Throw.pass(height: 1),
                Throw.pass(height: 1),
              ],
            ),
        isTrue,
      );
    });

    test('sorted correctly', () {
      expect(
          [
            Pattern(
              numberOfJugglers: 2,
              throwSequence: [
                Throw.self(height: 3),
                Throw.self(height: 3),
                Throw.pass(height: 1),
                Throw.pass(height: 1),
              ],
            ),
            Pattern(
              numberOfJugglers: 2,
              throwSequence: [
                Throw.self(height: 3),
                Throw.pass(height: 1),
                Throw.pass(height: 1),
                Throw.self(height: 3),
              ],
            ),
          ].sorted(),
          [
            Pattern(
              numberOfJugglers: 2,
              throwSequence: [
                Throw.self(height: 3),
                Throw.pass(height: 1),
                Throw.pass(height: 1),
                Throw.self(height: 3),
              ],
            ),
            Pattern(
              numberOfJugglers: 2,
              throwSequence: [
                Throw.self(height: 3),
                Throw.self(height: 3),
                Throw.pass(height: 1),
                Throw.pass(height: 1),
              ],
            ),
          ]);
    });

    test('supports value comparisons', () {
      expect(
        Pattern(
          numberOfJugglers: 2,
          throwSequence: [
            Throw.self(height: 4),
            Throw(height: 4.toFraction(), passingIndex: 3),
            Throw.pass(height: 4.5),
          ],
        ),
        Pattern(
          numberOfJugglers: 2,
          throwSequence: [
            Throw.self(height: 4),
            Throw(height: 4.toFraction(), passingIndex: 3),
            Throw.pass(height: 4.5),
          ],
        ),
      );
    });

    test('from valid ID', () {
      expect(
        Pattern.fromId('2_4-1-0_2-1-1_1-1-0_1-1-1'),
        mockPattern,
      );
    });

    test('from invalid ID is null', () {
      expect(
        Pattern.fromId('2_4-1-0_2-1-1_1-1-0_1-1-x'),
        isNull,
      );

      expect(
        Pattern.fromId('x_4-1-0_2-1-1_1-1-0_1-1-1'),
        isNull,
      );

      expect(
        Pattern.fromId('4-1-0_2-1-1_1-1-0_1-1-1'),
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
        ..add(
          Pattern(
            numberOfJugglers: 2,
            throwSequence: [Throw.pass(height: 3), Throw.pass(height: 1)],
          ),
        )
        ..add(
          Pattern(
            numberOfJugglers: 2,
            throwSequence: [Throw.pass(height: 3), Throw.pass(height: 1)],
          ),
        );
      expect(
        set,
        {
          Pattern(
            numberOfJugglers: 2,
            throwSequence: [Throw.pass(height: 3), Throw.pass(height: 1)],
          ),
        },
      );
    });

    test('rotates', () {
      expect(
        Pattern(
          numberOfJugglers: 4,
          throwSequence: [
            Throw.self(height: 4),
            Throw(height: 4.toFraction(), passingIndex: 3),
            Throw.pass(height: 4.5),
          ],
        ).rotate(),
        Pattern(
          numberOfJugglers: 4,
          throwSequence: [
            Throw(height: 4.toFraction(), passingIndex: 3),
            Throw.pass(height: 4.5),
            Throw.self(height: 4),
          ],
        ),
      );
    });

    test('allRotations returns list with all rotations', () {
      expect(
          Pattern(
            numberOfJugglers: 2,
            throwSequence: [
              Throw.self(height: 3),
              Throw.pass(height: 1),
              Throw.pass(height: 1),
              Throw.self(height: 3),
            ],
          ).allRotations(),
          [
            Pattern(
              numberOfJugglers: 2,
              throwSequence: [
                Throw.self(height: 3),
                Throw.pass(height: 1),
                Throw.pass(height: 1),
                Throw.self(height: 3),
              ],
            ),
            Pattern(
              numberOfJugglers: 2,
              throwSequence: [
                Throw.pass(height: 1),
                Throw.pass(height: 1),
                Throw.self(height: 3),
                Throw.self(height: 3),
              ],
            ),
            Pattern(
              numberOfJugglers: 2,
              throwSequence: [
                Throw.pass(height: 1),
                Throw.self(height: 3),
                Throw.self(height: 3),
                Throw.pass(height: 1),
              ],
            ),
            Pattern(
              numberOfJugglers: 2,
              throwSequence: [
                Throw.self(height: 3),
                Throw.self(height: 3),
                Throw.pass(height: 1),
                Throw.pass(height: 1),
              ],
            ),
          ]);
    });

    test('compares', () {
      final pattern1 = Pattern(
        numberOfJugglers: 2,
        throwSequence: [
          Throw.self(height: 3),
          Throw.pass(height: 1),
          Throw.pass(height: 1),
          Throw.self(height: 3),
        ],
      );
      final pattern2 = Pattern(
        numberOfJugglers: 2,
        throwSequence: [
          Throw.self(height: 3),
          Throw.self(height: 3),
          Throw.pass(height: 1),
          Throw.pass(height: 1),
        ],
      );

      expect(pattern1.compareTo(pattern2), -1);
    });

    group('normalizes', () {
      test('3 1p 1p 3', () {
        expect(
          Pattern(
            numberOfJugglers: 2,
            throwSequence: [
              Throw.self(height: 3),
              Throw.pass(height: 1),
              Throw.pass(height: 1),
              Throw.self(height: 3),
            ],
          ).normalize(),
          Pattern(
            numberOfJugglers: 2,
            throwSequence: [
              Throw.self(height: 3),
              Throw.self(height: 3),
              Throw.pass(height: 1),
              Throw.pass(height: 1),
            ],
          ),
        );
      });

      test('1 1p 4 2p', () {
        expect(
          Pattern(
            numberOfJugglers: 2,
            throwSequence: [
              Throw.self(height: 1),
              Throw.pass(height: 1),
              Throw.self(height: 4),
              Throw.pass(height: 2),
            ],
          ).normalize(),
          Pattern(
            numberOfJugglers: 2,
            throwSequence: [
              Throw.self(height: 4),
              Throw.pass(height: 2),
              Throw.self(height: 1),
              Throw.pass(height: 1),
            ],
          ),
        );
      });
    });

    test('has correct string representation', () {
      expect(
        Pattern(
          numberOfJugglers: 4,
          throwSequence: [
            Throw.self(height: 4),
            Throw(height: 4.toFraction(), passingIndex: 3),
            Throw.pass(height: 4.5),
          ],
        ).toString(),
        '4 4p₃ 4.5p₁',
      );
    });

    test('throwAtIndex returns correct throw', () {
      final pattern = Pattern(
        numberOfJugglers: 4,
        throwSequence: [
          Throw.self(height: 4),
          Throw(height: 4.toFraction(), passingIndex: 3),
          Throw.pass(height: 4.5),
        ],
      );
      expect(
        pattern.throwAtIndex(2),
        Throw.pass(height: 4.5),
      );
    });

    test(
        'throwAtIndexToString returns correct string representation '
        'for 4 jugglers', () {
      final pattern = Pattern(
        numberOfJugglers: 4,
        throwSequence: [
          Throw.self(height: 4),
          Throw(height: 4.toFraction(), passingIndex: 3),
          Throw.pass(height: 4.5),
        ],
      );
      expect(
        pattern.throwAtIndexToString(2),
        '4.5p₁',
      );
    });

    test(
        'throwAtIndexToString returns correct string representation '
        'for 2 jugglers', () {
      final pattern = Pattern(
        numberOfJugglers: 2,
        throwSequence: [
          Throw.self(height: 4),
          Throw(height: 4.toFraction(), passingIndex: 3),
          Throw.pass(height: 4.5),
        ],
      );
      expect(
        pattern.throwAtIndexToString(2),
        '4.5p',
      );
    });

    test('throw are iterable', () {
      final pattern = Pattern(
        numberOfJugglers: 4,
        throwSequence: [
          Throw.self(height: 4),
          Throw(height: 4.toFraction(), passingIndex: 3),
          Throw.pass(height: 4.5),
        ],
      );
      final heights =
          pattern.map((element) => element.height.toDouble()).toList();
      expect(
        heights,
        [4, 4, 4.5],
      );
    });

    test('copyWithThrow returns correct pattern', () {
      final pattern = Pattern(
        numberOfJugglers: 4,
        throwSequence: [
          Throw.self(height: 4),
          Throw(height: 4.toFraction(), passingIndex: 3),
          Throw.pass(height: 4.5),
        ],
      );
      expect(
        pattern.copyWithThrow(newThrow: Throw.self(height: 2), index: 1),
        Pattern(
          numberOfJugglers: 4,
          throwSequence: [
            Throw.self(height: 4),
            Throw.self(height: 2),
            Throw.pass(height: 4.5),
          ],
        ),
      );
    });

    test('number of passes calculated correctly', () {
      final pattern = Pattern(
        numberOfJugglers: 4,
        throwSequence: [
          Throw.self(height: 4),
          Throw(height: 4.toFraction(), passingIndex: 3),
          Throw.pass(height: 4.5),
        ],
      );
      expect(
        pattern.numberOfPasses,
        2,
      );
    });

    test('number of objects calculated correctly', () {
      final pattern = Pattern(
        numberOfJugglers: 4,
        throwSequence: [
          Throw.self(height: 4),
          Throw(height: 3.5.toFraction(), passingIndex: 3),
          Throw.pass(height: 4.5),
        ],
      );
      expect(
        pattern.numberOfObjects,
        16.toFraction(),
      );
    });

    group('mapThrowsAsStringWithStyle', () {
      test('4 2p 1 1p', () {
        expect(
          mockPattern
              .mapThrowsAsStringWithStyle((string, style) => '$string $style')
              .toList(),
          [
            '4 ThrowStyle.self',
            '2p ThrowStyle.equi',
            '1 ThrowStyle.self',
            '1p ThrowStyle.classic',
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
          pattern
              .mapThrowsAsStringWithStyle((string, style) => '$string $style')
              .toList(),
          [
            '2.5p ThrowStyle.instantBi',
            '2.5p ThrowStyle.instantBi',
            '2 ThrowStyle.self',
            '1.5p ThrowStyle.bi',
            '1.5p ThrowStyle.bi',
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
          pattern
              .mapThrowsAsStringWithStyle((string, style) => '$string $style')
              .toList(),
          [
            '3.3p₂ ThrowStyle.bi',
            '2.6p₁ ThrowStyle.bi',
            '2.3p₂ ThrowStyle.instantBi',
            '1.6p₁ ThrowStyle.instantBi',
            '1.6p₁ ThrowStyle.instantBi',
          ],
        );
      });
    });

    group('timeBetweenThrows', () {
      test('3 1p 1p 3', () {
        expect(
          Pattern(
            numberOfJugglers: 2,
            throwSequence: [
              Throw.self(height: 3),
              Throw.pass(height: 1),
              Throw.pass(height: 1),
              Throw.self(height: 3),
            ],
          ).timeBetweenThrows(),
          1.toFraction(),
        );
      });

      test('3.3p 2.6p 2.3p 1.6p 1.6p', () {
        expect(
          Pattern(
            numberOfJugglers: 3,
            throwSequence: [
              Throw(height: Fraction(10, 3), passingIndex: 2),
              Throw(height: Fraction(8, 3), passingIndex: 1),
              Throw(height: Fraction(7, 3), passingIndex: 2),
              Throw(height: Fraction(5, 3), passingIndex: 1),
              Throw(height: Fraction(5, 3), passingIndex: 1),
            ],
          ).timeBetweenThrows(),
          Fraction(1, 3),
        );
      });
    });
  });
}
