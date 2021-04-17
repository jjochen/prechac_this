import 'package:pattern_repository/pattern_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pattern', () {
    test('supports value comparisons', () {
      expect(
        Pattern([
          SimpleThrow(height: 4),
          SimpleThrow.placeholder(),
          Multiplex([
            SimpleThrow.placeholder(),
            SimpleThrow(height: 4.5, passingIndex: 1),
          ]),
        ]),
        Pattern([
          SimpleThrow(height: 4),
          SimpleThrow.placeholder(),
          Multiplex([
            SimpleThrow.placeholder(),
            SimpleThrow(height: 4.5, passingIndex: 1),
          ]),
        ]),
      );
    });

    test('has correct string representation', () {
      expect(
        Pattern([
          SimpleThrow(height: 4),
          SimpleThrow.placeholder(),
          Multiplex([
            SimpleThrow.placeholder(),
            SimpleThrow(height: 4.5, passingIndex: 1),
          ]),
        ]).toString(),
        '4, _, [_, 4.5p1]',
      );
    });
  });
}
