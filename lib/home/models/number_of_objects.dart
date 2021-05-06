import 'package:formz/formz.dart';

enum NumberOfObjectsValidationError { invalid }

class NumberOfObjects extends FormzInput<int, NumberOfObjectsValidationError> {
  const NumberOfObjects.pure() : super.pure(defaultValue);
  const NumberOfObjects.dirty([int value = defaultValue]) : super.dirty(value);

  static const int defaultValue = 4;
  static const int minValue = 1;
  static const int maxValue = 24;

  @override
  NumberOfObjectsValidationError? validator(int? value) {
    return (value != null && value >= minValue && value <= maxValue)
        ? null
        : NumberOfObjectsValidationError.invalid;
  }
}
