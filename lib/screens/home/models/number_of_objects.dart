import 'package:formz/formz.dart';

enum NumberOfObjectsValidationError { requiredFieldMissing, outOfRange }

class NumberOfObjects extends FormzInput<int, NumberOfObjectsValidationError> {
  const NumberOfObjects.pure() : super.pure(defaultValue);
  const NumberOfObjects.dirty([int value = defaultValue]) : super.dirty(value);

  static const int defaultValue = 4;
  static const int minValue = 1;
  static const int maxValue = 24;

  @override
  NumberOfObjectsValidationError? validator(int? value) {
    if (value == null) {
      return NumberOfObjectsValidationError.requiredFieldMissing;
    } else if (value < minValue || value > maxValue) {
      return NumberOfObjectsValidationError.outOfRange;
    } else {
      return null;
    }
  }
}
