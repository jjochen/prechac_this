// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/core/joinable.dart';
import 'package:test/test.dart';

void main() {
  group('Joinable', () {
    test('joinToList', () {
      expect(
        [1, 2, 3].joinToList(0),
        [1, 0, 2, 0, 3],
      );
      expect(
        [].joinToList(0),
        [],
      );
    });
  });
}
