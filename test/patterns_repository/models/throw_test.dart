import 'package:flutter_test/flutter_test.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/models/throw.dart';

void main() {
  group('Throw', () {
    test('supports comparison of heights', () {
      expect(
        Throw.self(height: 3) < Throw.self(height: 4),
        isTrue,
      );
    });

    test('supports comparison of passing index', () {
      expect(
        Throw.self(height: 4) < Throw.pass(height: 4),
        isTrue,
      );
    });

    test('compares height first', () {
      expect(
        Throw.pass(height: 3) < Throw.self(height: 4),
        isTrue,
      );
    });

    test('from valid ID', () {
      expect(
        Throw.fromId('4-1-0'),
        Throw.self(height: 4),
      );
    });

    test('from invalid ID is null', () {
      expect(Throw.fromId('4-1'), isNull);
      expect(Throw.fromId('4-1-x'), isNull);
    });

    test('supports representation as ID', () {
      final aThrow = Throw(height: Fraction(4, 3), passingIndex: 2);
      expect(
        Throw.fromId(aThrow.id),
        aThrow,
      );
    });

    group('Self', () {
      test('supports value comparisons', () {
        expect(
          Throw.self(height: 4),
          Throw.self(height: 4),
        );
      });

      test('has correct string representation', () {
        expect(
          Throw.self(height: 42).toString(),
          '42',
        );
      });

      test('isSelf returns true', () {
        expect(
          Throw.self(height: 4).isSelf,
          true,
        );
      });

      test('isPass returns false', () {
        expect(
          Throw.self(height: 4).isPass,
          false,
        );
      });
    });

    group('Pass', () {
      test('supports value comparisons', () {
        expect(
          Throw.pass(height: 4.5),
          Throw.pass(height: 4.5),
        );
      });

      test('has correct string representation', () {
        expect(
          Throw.pass(height: 4).toString(),
          '4p',
        );

        expect(
          Throw.pass(height: 42.25).toString(),
          '42.25p',
        );

        expect(
          Throw.pass(height: 42.257).toString(),
          '42.2p',
        );

        expect(
          Throw(height: Fraction(5, 3), passingIndex: 2).toString(),
          '1.6p₂',
        );

        expect(
          Throw(height: Fraction(4, 3), passingIndex: 1).toString(),
          '1.3p',
        );
      });

      test('isSelf returns false', () {
        expect(
          Throw.pass(height: 4).isSelf,
          false,
        );
      });

      test('isPass returns true', () {
        expect(
          Throw.pass(height: 4).isPass,
          true,
        );
      });
    });
  });
}
