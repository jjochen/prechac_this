import 'package:flutter_test/flutter_test.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/repositories/pattern_repository/models/throw_constraint.dart';

void main() {
  group('ThrowConstraint', () {
    test('supports comparison of heights', () {
      expect(
        ThrowConstraint.self(height: null) < ThrowConstraint.self(height: 0),
        isTrue,
      );

      expect(
        ThrowConstraint.self(height: null) < ThrowConstraint.self(height: -1),
        isTrue,
      );

      expect(
        ThrowConstraint.self(height: 1) > ThrowConstraint.self(height: null),
        isTrue,
      );
    });

    test('orders placeholders correctly', () {
      expect(
        const ThrowConstraint(height: null, passingIndex: null) <
            const ThrowConstraint(height: null, passingIndex: 0),
        isTrue,
      );
    });

    test('supports comparison of passing index', () {
      expect(
        ThrowConstraint.pass(height: 1, passingIndex: null) <
            ThrowConstraint.pass(height: 1, passingIndex: 0),
        isTrue,
      );

      expect(
        ThrowConstraint.pass(height: 1, passingIndex: 0) >
            ThrowConstraint.pass(height: 1, passingIndex: null),
        isTrue,
      );
    });

    test('compares height first', () {
      expect(
        ThrowConstraint.pass(height: 3) < ThrowConstraint.self(height: 4),
        isTrue,
      );
    });

    group('Self', () {
      test('supports value comparisons', () {
        expect(
          ThrowConstraint.self(height: 4),
          ThrowConstraint.self(height: 4),
        );
      });

      test('has correct string representation', () {
        expect(
          ThrowConstraint.self(height: 42).toString(),
          '42',
        );

        expect(
          ThrowConstraint.self(height: null).toString(),
          '_',
        );
      });

      test('isSelf returns true', () {
        expect(
          ThrowConstraint.self(height: 4).isSelf,
          true,
        );
      });

      test('isPass returns false', () {
        expect(
          ThrowConstraint.self(height: 4).isPass,
          false,
        );
      });
    });

    group('Pass', () {
      test('supports value comparisons', () {
        expect(
          ThrowConstraint.pass(height: 4.5),
          ThrowConstraint.pass(height: 4.5),
        );
      });

      test('has correct string representation', () {
        expect(
          ThrowConstraint.pass(height: 42.25).toString(),
          '42.25p1',
        );

        expect(
          ThrowConstraint(height: Fraction(4, 3), passingIndex: 2).toString(),
          '1.3p2',
        );

        expect(
          ThrowConstraint(height: Fraction(5, 3), passingIndex: 1).toString(),
          '1.6p1',
        );

        expect(
          ThrowConstraint.pass(height: null).toString(),
          '_p1',
        );

        expect(
          ThrowConstraint.pass(height: 1, passingIndex: null).toString(),
          '1p_',
        );
      });

      test('isSelf returns false', () {
        expect(
          ThrowConstraint.pass(height: 4).isSelf,
          false,
        );
      });

      test('isPass returns true', () {
        expect(
          ThrowConstraint.pass(height: 4).isPass,
          true,
        );
      });
    });

    group('Placeholder', () {
      test('supports value comparisons', () {
        expect(
          ThrowConstraint.placeholder(),
          ThrowConstraint.placeholder(),
        );
      });

      test('has correct string representation', () {
        expect(
          ThrowConstraint.placeholder().toString(),
          '_',
        );
      });
    });
  });
}