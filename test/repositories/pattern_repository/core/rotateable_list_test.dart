import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/repositories/pattern_repository/core/rotateable_list.dart';

void main() {
  group('RotateableList', () {
    late List list;
    setUp(() {
      list = [1, 2, 3];
    });

    test('rotates 1', () {
      expect(
        list.rotate(),
        [2, 3, 1],
      );
    });

    test('rotates -1', () {
      expect(
        list.rotate(-1),
        [3, 1, 2],
      );
    });

    test('rotates length to list', () {
      expect(
        list.rotate(list.length),
        list,
      );
    });

    test('rotates (length + 1)', () {
      expect(
        list.rotate(4),
        [2, 3, 1],
      );
    });

    test('rotates -(length + 1)', () {
      expect(
        list.rotate(-4),
        [3, 1, 2],
      );
    });
  });
}
