import 'package:pattern_repository/pattern_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Throw', () {
    group('SimpleThrow', () {
      test('supports value comparisons', () {
        expect(
          SimpleThrow(height: 4.5, passingIndex: 1),
          SimpleThrow(height: 4.5, passingIndex: 1),
        );
      });

      test('has correct string representation', () {
        expect(
          SimpleThrow(height: 42.25, passingIndex: 1).toString(),
          '42.25p1',
        );

        expect(
          SimpleThrow(height: 4, passingIndex: 0).toString(),
          '4',
        );

        // expect(
        //   SimpleThrow(height: 4 / 3, passingIndex: 2).toString(),
        //   '1.3p2',
        // );

        // expect(
        //   SimpleThrow(height: 5 / 3, passingIndex: 1).toString(),
        //   '1.6p1',
        // );

        expect(
          SimpleThrow(height: null, passingIndex: 1).toString(),
          '_p1',
        );

        expect(
          SimpleThrow(height: 1, passingIndex: null).toString(),
          '1p_',
        );
      });
    });

    group('Placeholder', () {
      test('supports value comparisons', () {
        expect(
          SimpleThrow.placeholder(),
          SimpleThrow.placeholder(),
        );
      });

      test('equivalent to throw with null object', () {
        expect(
          SimpleThrow.placeholder(),
          SimpleThrow(height: null, passingIndex: null),
        );
      });

      test('has correct string representation', () {
        expect(
          SimpleThrow.placeholder().toString(),
          '_',
        );
      });
    });

    group('Multiplex Throw', () {
      test('supports value comparisons', () {
        expect(
          Multiplex([
            SimpleThrow.placeholder(),
            SimpleThrow(height: 4.5, passingIndex: 1),
          ]),
          Multiplex([
            SimpleThrow.placeholder(),
            SimpleThrow(height: 4.5, passingIndex: 1),
          ]),
        );
      });

      test('has correct string representation', () {
        expect(
          Multiplex([
            SimpleThrow(height: 4.5, passingIndex: 1),
            SimpleThrow.placeholder(),
          ]).toString(),
          '[4.5p1, _]',
        );
      });
    });
  });
}
