import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/repositories/pattern_repository/engine/landing_sites.dart';

void main() {
  group('List of landing sites', () {
    test('is filled with missing sites', () {
      expect(
        [5, -1, 0, 1, -1].fillMissingSites([3, 1]),
        [5, 3, 0, 1, 1],
      );
    });
  });
}
