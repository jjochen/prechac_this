// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/screens/home/models/period.dart';
import 'package:test/test.dart';

void main() {
  group('Period', () {
    test('error text for valid input is null', () {
      final input = Period.dirty(1);
      expect(
        input.errorText,
        isNull,
      );
    });

    test('has correct error text for out of range input', () {
      final input = Period.dirty(0);
      expect(
        input.errorText,
        'value should be between 1 and 24',
      );
    });
  });
}
