import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/patterns_repository/engine/prechac_pattern.dart';

import '../../helpers/helpers.dart';

void main() {
  group('PrechacPattern', () {
    test('is valid', () async {
      expect(
        mockPattern.isValid(
          numberOfObjects: 4,
          numberOfJugglers: 2,
          minNumberOfPasses: 1,
          maxNumberOfPasses: 2,
        ),
        isTrue,
      );
    });

    test('is not valid with incorrect number of passes', () async {
      expect(
        mockPattern.isValid(
          numberOfObjects: 4,
          numberOfJugglers: 2,
          minNumberOfPasses: 1,
          maxNumberOfPasses: 1,
        ),
        isFalse,
      );
    });

    test('is not valid with incorrect number of objects', () async {
      expect(
        mockPattern.isValid(
          numberOfObjects: 5,
          numberOfJugglers: 2,
          minNumberOfPasses: 1,
          maxNumberOfPasses: 1,
        ),
        isFalse,
      );
    });
  });
}
