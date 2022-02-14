// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/home/models/form_input_exception.dart';
import 'package:prechac_this/home/models/min_number_of_passes.dart';
import 'package:test/test.dart';

void main() {
  group('MinNumberOfPasses', () {
    test('error text for valid input is null', () {
      final input = MinNumberOfPasses.dirty(5);
      expect(
        input.error,
        isNull,
      );
    });

    test('error text for null input is null', () {
      final input = MinNumberOfPasses.dirty(null);
      expect(
        input.error,
        isNull,
      );
    });

    test('has correct error text for out of range input', () {
      final input = MinNumberOfPasses.dirty(25);
      expect(
        input.error,
        InputOutOfRangeException(
          MinNumberOfPasses.minValue,
          MinNumberOfPasses.maxValue,
        ),
      );
    });
  });
}
