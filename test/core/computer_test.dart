// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/core/computer.dart';
import 'package:test/test.dart';

String validMethod(int message) => message.toString();
String throwingMethod(int message) => throw Exception('test method');

void main() {
  group('Computer', () {
    late Computer<int, String> computer;

    setUp(() {
      computer = Computer<int, String>();
    });

    test('completes', () async {
      expect(
          computer.run(validMethod, 1).then((output) {
            expect(output, '1');
          }).catchError((error) {
            assert(false);
          }),
          completes);
    });

    test('passes error', () async {
      expect(
          computer.run(throwingMethod, 1).then((output) {
            assert(false);
          }).catchError((error) {
            expect(error, isA<Exception>());
          }),
          completes);
    });
  });
}
