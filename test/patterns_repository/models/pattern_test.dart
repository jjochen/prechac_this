import 'package:dartx/dartx.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/models/models.dart';

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
        ..add(Pattern(
          numberOfJugglers: 2,
          throwSequence: [Throw.pass(height: 3), Throw.pass(height: 1)],
        ))
        ..add(Pattern(
          numberOfJugglers: 2,
          throwSequence: [Throw.pass(height: 3), Throw.pass(height: 1)],
        ));
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
        'throwAtIndexToString returns correct string representation'
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
        'throwAtIndexToString returns correct string representation'
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
        pattern.numberOfPasses(),
        2,
      );
    });

    test('number of objects calculated correctly', () {
      final pattern = Pattern(
        numberOfJugglers: 4,
        throwSequence: [
          Throw.self(height: 4),
          Throw(height: (3.5).toFraction(), passingIndex: 3),
          Throw.pass(height: 4.5),
        ],
      );
      expect(
        pattern.numberOfObjects,
        16.toFraction(),
      );
    });
  });
}
