import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/repositories/pattern_repository/engine/prechac_pattern.dart';
import 'package:prechac_this/repositories/pattern_repository/models/pattern.dart';
import 'package:prechac_this/repositories/pattern_repository/models/throw.dart';

void main() {
  group('PrechacPattern', () {
    test('is valid', () async {
      final pattern = Pattern([
        Throw.self(height: 4),
        Throw.pass(height: 2),
        Throw.self(height: 1),
        Throw.pass(height: 1),
      ]);
      expect(
        pattern.isValid(
          numberOfObjects: 4,
          numberOfJugglers: 2,
          minNumberOfPasses: 1,
          maxNumberOfPasses: 2,
        ),
        isTrue,
      );
    });

    test('is not valid with incorrect number of passes', () async {
      final pattern = Pattern([
        Throw.self(height: 4),
        Throw.pass(height: 2),
        Throw.self(height: 1),
        Throw.pass(height: 1),
      ]);
      expect(
        pattern.isValid(
          numberOfObjects: 4,
          numberOfJugglers: 2,
          minNumberOfPasses: 1,
          maxNumberOfPasses: 1,
        ),
        isFalse,
      );
    });

    test('is not valid with incorrect number of objects', () async {
      final pattern = Pattern([
        Throw.self(height: 4),
        Throw.pass(height: 2),
        Throw.self(height: 1),
        Throw.pass(height: 1),
      ]);
      expect(
        pattern.isValid(
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
