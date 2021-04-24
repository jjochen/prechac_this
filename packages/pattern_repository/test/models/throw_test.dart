import 'package:flutter_test/flutter_test.dart';
import 'package:pattern_repository/src/models/throw.dart';

void main() {
  group('Throw', () {
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

        expect(
          Throw.self(height: null).toString(),
          '_',
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

        expect(
          Throw.pass(height: null).toString(),
          '_p1',
        );

        expect(
          Throw.pass(height: 1, passingIndex: null).toString(),
          '1p_',
        );
      });
    });

    group('Placeholder', () {
      test('supports value comparisons', () {
        expect(
          Throw.placeholder(),
          Throw.placeholder(),
        );
      });

      test('has correct string representation', () {
        expect(
          Throw.placeholder().toString(),
          '_',
        );
      });
    });
  });
}
