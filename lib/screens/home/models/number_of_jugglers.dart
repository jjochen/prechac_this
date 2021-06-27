import 'package:formz/formz.dart';

enum NumberOfJugglersValidationError { requiredFieldMissing, outOfRange }

class NumberOfJugglers
    extends FormzInput<int, NumberOfJugglersValidationError> {
  const NumberOfJugglers.pure() : super.pure(defaultValue);
  const NumberOfJugglers.dirty([int value = defaultValue]) : super.dirty(value);

  static const int defaultValue = 2;
  static const int minValue = 1;
  static const int maxValue = 24;

  @override
  NumberOfJugglersValidationError? validator(int? value) {
    if (value == null) {
      return NumberOfJugglersValidationError.requiredFieldMissing;
    } else if (value < minValue || value > maxValue) {
      return NumberOfJugglersValidationError.outOfRange;
    }
    return null;
  }
}
