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
          Throw(height: 4.5, passingIndex: 1),
          Throw(height: 4.5, passingIndex: 1),
        );
      });

      test('has correct string representation', () {
        expect(
          Throw(height: 42.25, passingIndex: 1).toString(),
          '42.25p1',
        );

        // expect(
        //   Throw(height: 4 / 3, passingIndex: 2).toString(),
        //   '1.3p2',
        // );

        // expect(
        //   Throw(height: 5 / 3, passingIndex: 1).toString(),
        //   '1.6p1',
        // );

        expect(
          Throw(height: null, passingIndex: 1).toString(),
          '_p1',
        );

        expect(
          Throw(height: 1, passingIndex: null).toString(),
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
