import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/core/joinable.dart';

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
