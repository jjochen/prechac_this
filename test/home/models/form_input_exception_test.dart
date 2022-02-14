// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/home/models/form_input_exception.dart';
import 'package:test/test.dart';

void main() {
  group('FormInputValidationException', () {
    group('InputOutOfRangeException', () {
      test('supports value comparisons', () {
        expect(
          InputOutOfRangeException(1, 2),
          InputOutOfRangeException(1, 2),
        );
      });
    });
  });
}
