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
    });
  });
}
