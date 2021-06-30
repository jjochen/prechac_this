// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/screens/home/models/number_of_jugglers.dart';
import 'package:test/test.dart';

void main() {
  group('NumberOfJugglers', () {
    test('calculates cartesian product', () {
      final numberOfJugglers = NumberOfJugglers.dirty(0);
      expect(
        numberOfJugglers.errorText,
        'value should be between 1 and 24',
      );
    });
  });
}
