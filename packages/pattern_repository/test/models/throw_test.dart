import 'package:pattern_repository/pattern_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Throw', () {
    group('Self', () {
      test('supports value comparisons', () {
        expect(
          Self(height: 4),
          Self(height: 4),
        );
      });

      test('has correct string representation', () {
        expect(
          Self(height: 42).toString(),
          '42',
        );

        expect(
          Self(height: null).toString(),
          '_',
        );
      });
    });

    group('Pass', () {
      test('supports value comparisons', () {
        expect(
          Pass(height: 4.5, passingIndex: 1),
          Pass(height: 4.5, passingIndex: 1),
        );
      });

      test('has correct string representation', () {
        expect(
          Pass(height: 42.25, passingIndex: 1).toString(),
          '42.25p1',
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
          Pass(height: null, passingIndex: 1).toString(),
          '_p1',
        );

        expect(
          Pass(height: 1, passingIndex: null).toString(),
          '1p_',
        );
      });
    });

    group('Placeholder', () {
      test('supports value comparisons', () {
        expect(
          Placeholder(),
          Placeholder(),
        );
      });

      test('has correct string representation', () {
        expect(
          Placeholder().toString(),
          '_',
        );
      });
    });

    // group('Multiplex Throw', () {
    //   test('supports value comparisons', () {
    //     expect(
    //       Multiplex([
    //         Placeholder(),
    //         SimpleThrow(height: 4.5, passingIndex: 1),
    //       ]),
    //       Multiplex([
    //         Placeholder(),
    //         SimpleThrow(height: 4.5, passingIndex: 1),
    //       ]),
    //     );
    //   });

    //   test('has correct string representation', () {
    //     expect(
    //       Multiplex([
    //         SimpleThrow(height: 4.5, passingIndex: 1),
    //         Placeholder(),
    //       ]).toString(),
    //       '[4.5p1, _]',
    //     );
    //   });
    // });
  });
}
