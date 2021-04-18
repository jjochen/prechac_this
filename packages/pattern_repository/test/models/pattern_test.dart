import 'package:pattern_repository/pattern_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pattern', () {
    test('supports value comparisons', () {
      expect(
        Pattern([
          Self(height: 4),
          Placeholder(),
          Pass(height: 4.5, passingIndex: 1),
        ]),
        Pattern([
          Self(height: 4),
          Placeholder(),
          Pass(height: 4.5, passingIndex: 1),
        ]),
      );
    });

    test('has correct string representation', () {
      expect(
        Pattern([
          Self(height: 4),
          Placeholder(),
          Pass(height: 4.5, passingIndex: 1),
        ]).toString(),
        '4, _, 4.5p1',
      );
    });
  });
}
