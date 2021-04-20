import 'package:flutter_test/flutter_test.dart';
import 'package:pattern_repository/pattern_repository.dart';

void main() {
  group('Constraints', () {
    late Constraints constraints;

    setUp(() {
      constraints = const Constraints(
        numberOfJugglers: 2,
        period: 4,
        numberOfObjects: 5,
        maxHeight: 6,
      );
    });

    test('has correct default values for optional parameters', () {
      expect(
        constraints.minNumberOfPasses,
        0,
      );
      expect(
        constraints.maxNumberOfPasses,
        4,
      );
      expect(
        constraints.contains,
        isNull,
      );
    });

    test('supports value comparisons', () {
      expect(
        constraints,
        const Constraints(
          numberOfJugglers: 2,
          period: 4,
          numberOfObjects: 5,
          maxHeight: 6,
        ),
      );
    });

    test('has correct string representation', () {
      expect(
        constraints.toString(),
        'Constraints(2, 4, 5, 6, 0, 4, null)',
      );
    });
  });
}
