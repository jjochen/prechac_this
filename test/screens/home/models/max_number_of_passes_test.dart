// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/screens/home/models/form_input_exception.dart';
import 'package:prechac_this/screens/home/models/max_number_of_passes.dart';
import 'package:test/test.dart';

void main() {
  group('MaxNumberOfPasses', () {
    test('error text for valid input is null', () {
      final input = MaxNumberOfPasses.dirty(5);
      expect(
        input.error,
        isNull,
      );
    });

    test('error text for null input is null', () {
      final input = MaxNumberOfPasses.dirty(null);
      expect(
        input.error,
        isNull,
      );
    });

    test('has correct error text for out of range input', () {
      final input = MaxNumberOfPasses.dirty(25);
      expect(
        input.error,
        InputOutOfRangeException(
          'value should be between -1 and 24',
        ),
      );
    });
  });
}
