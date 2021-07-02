// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/screens/home/models/form_input_exception.dart';
import 'package:prechac_this/screens/home/models/number_of_jugglers.dart';
import 'package:test/test.dart';

void main() {
  group('NumberOfJugglers', () {
    test('error text for valid input is null', () {
      final input = NumberOfJugglers.dirty(1);
      expect(
        input.error,
        isNull,
      );
    });

    test('has correct error text for out of range input', () {
      final input = NumberOfJugglers.dirty(0);
      expect(
        input.error,
        InputOutOfRangeException(
          'value should be between 1 and 24',
        ),
      );
    });
  });
}
