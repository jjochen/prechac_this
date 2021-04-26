import 'package:flutter_test/flutter_test.dart';
import 'package:pattern_repository/src/models/throw_constraints.dart';

void main() {
  group('ThrowConstraints', () {
    group('Self', () {
      test('supports value comparisons', () {
        expect(
          ThrowConstraints.self(height: 4),
          ThrowConstraints.self(height: 4),
        );
      });

      test('has correct string representation', () {
        expect(
          ThrowConstraints.self(height: 42).toString(),
          '42',
        );

        expect(
          ThrowConstraints.self(height: null).toString(),
          '_',
        );
      });

      test('isSelf returns true', () {
        expect(
          ThrowConstraints.self(height: 4).isSelf,
          true,
        );
      });

      test('isPass returns false', () {
        expect(
          ThrowConstraints.self(height: 4).isPass,
          false,
        );
      });
    });

    group('Pass', () {
      test('supports value comparisons', () {
        expect(
          ThrowConstraints.pass(height: 4.5),
          ThrowConstraints.pass(height: 4.5),
        );
      });

      test('has correct string representation', () {
        expect(
          ThrowConstraints.pass(height: 42.25).toString(),
          '42.25p1',
        );

        // expect(
        //   ThrowConstraints(height: 4 / 3, passingIndex: 2).toString(),
        //   '1.3p2',
        // );

        // expect(
        //   ThrowConstraints(height: 5 / 3).toString(),
        //   '1.6p1',
        // );

        expect(
          ThrowConstraints.pass(height: null).toString(),
          '_p1',
        );

        expect(
          ThrowConstraints.pass(height: 1, passingIndex: null).toString(),
          '1p_',
        );
      });

      test('isSelf returns false', () {
        expect(
          ThrowConstraints.pass(height: 4).isSelf,
          false,
        );
      });

      test('isPass returns true', () {
        expect(
          ThrowConstraints.pass(height: 4).isPass,
          true,
        );
      });
    });

    group('Placeholder', () {
      test('supports value comparisons', () {
        expect(
          ThrowConstraints.placeholder(),
          ThrowConstraints.placeholder(),
        );
      });

      test('has correct string representation', () {
        expect(
          ThrowConstraints.placeholder().toString(),
          '_',
        );
      });
    });
  });
}
