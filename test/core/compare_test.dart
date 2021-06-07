// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/core/compare.dart';
import 'package:test/test.dart';

class TestObject with Comparable<TestObject>, Compare<TestObject> {
  TestObject(this.property);
  final int property;

  @override
  int compareTo(TestObject other) {
    return property.compareTo(other.property);
  }
}

void main() {
  group('Compare', () {
    group('less equal', () {
      test('1 <= 2', () {
        expect(
          TestObject(1) <= TestObject(2),
          isTrue,
        );
      });
      test('2 <= 2', () {
        expect(
          TestObject(2) <= TestObject(2),
          isTrue,
        );
      });
      test('not 3 <= 2', () {
        expect(
          TestObject(3) <= TestObject(2),
          isFalse,
        );
      });
    });

    group('less', () {
      test('1 < 2', () {
        expect(
          TestObject(1) < TestObject(2),
          isTrue,
        );
      });
      test('not 2 < 2', () {
        expect(
          TestObject(2) < TestObject(2),
          isFalse,
        );
      });
      test('not 3 < 2', () {
        expect(
          TestObject(3) < TestObject(2),
          isFalse,
        );
      });
    });

    group('greater equal', () {
      test('2 >= 1', () {
        expect(
          TestObject(2) >= TestObject(1),
          isTrue,
        );
      });
      test('2 >= 2', () {
        expect(
          TestObject(2) >= TestObject(2),
          isTrue,
        );
      });
      test('not 2 >= 3', () {
        expect(
          TestObject(2) >= TestObject(3),
          isFalse,
        );
      });
    });

    group('greater', () {
      test('2 > 1', () {
        expect(
          TestObject(2) > TestObject(1),
          isTrue,
        );
      });
      test('not 2 > 2', () {
        expect(
          TestObject(2) > TestObject(2),
          isFalse,
        );
      });
      test('not 1 > 2', () {
        expect(
          TestObject(1) > TestObject(2),
          isFalse,
        );
      });
    });

    group('equal', () {
      test('1 == 1', () {
        expect(
          TestObject(1) == TestObject(1),
          isTrue,
        );
      });
      test('not 1 == 2', () {
        expect(
          TestObject(1) == TestObject(2),
          isFalse,
        );
      });
      test('not 2 == 1', () {
        expect(
          TestObject(2) == TestObject(1),
          isFalse,
        );
      });
    });
  });
}
