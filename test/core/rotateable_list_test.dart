// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/core/rotateable_list.dart';
import 'package:test/test.dart';

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
