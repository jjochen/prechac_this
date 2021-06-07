// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/patterns_repository/engine/landing_sites.dart';
import 'package:test/test.dart';

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
