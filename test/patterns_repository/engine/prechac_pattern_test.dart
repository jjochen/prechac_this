// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/patterns_repository/engine/prechac_pattern.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PrechacPattern', () {
    group('satisfiesConstraint', () {
      test('returns true when constraints are satisfied', () async {
        expect(
          mockPattern.satisfiesConstraint(
            PatternConstraint(
              numberOfObjects: 4,
              numberOfJugglers: 2,
              maxHeight: 4,
              minNumberOfPasses: 1,
              maxNumberOfPasses: 2,
              throwSequence: [],
            ),
          ),
          isTrue,
        );
      });

      test('returns false with incorrect number of passes', () async {
        expect(
          mockPattern.satisfiesConstraint(
            PatternConstraint(
              numberOfObjects: 4,
              numberOfJugglers: 2,
              maxHeight: 4,
              minNumberOfPasses: 1,
              maxNumberOfPasses: 1,
              throwSequence: [],
            ),
          ),
          isFalse,
        );
      });

      test('returns false with incorrect number of objects', () async {
        expect(
          mockPattern.satisfiesConstraint(
            PatternConstraint(
              numberOfObjects: 5,
              numberOfJugglers: 2,
              maxHeight: 4,
              minNumberOfPasses: 1,
              maxNumberOfPasses: 2,
              throwSequence: [],
            ),
          ),
          isFalse,
        );
      });
    });
  });
}
