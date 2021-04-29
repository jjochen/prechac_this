import 'package:flutter_test/flutter_test.dart';
import 'package:pattern_repository/src/models/throw.dart';

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
          Throw.pass(height: 42.25).toString(),
          '42.25p1',
        );

        // expect(
        //   Throw(height: 4 / 3, passingIndex: 2).toString(),
        //   '1.3p2',
        // );

        // expect(
        //   Throw(height: 5 / 3).toString(),
        //   '1.6p1',
        // );
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
