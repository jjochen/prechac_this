// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/home/models/form_input_exception.dart';
import 'package:prechac_this/home/models/period.dart';
import 'package:test/test.dart';

void main() {
  group('Period', () {
    test('error text for valid input is null', () {
      final input = Period.dirty(1);
      expect(
        input.error,
        isNull,
      );
    });

    test('has correct error text for out of range input', () {
      final input = Period.dirty(0);
      expect(
        input.error,
        InputOutOfRangeException(
          Period.minValue,
          Period.maxValue,
        ),
      );
    });
  });
}
