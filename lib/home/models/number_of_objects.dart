import 'package:formz/formz.dart';

enum NumberOfObjectsValidationError { invalid }

class NumberOfObjects extends FormzInput<int, NumberOfObjectsValidationError> {
  const NumberOfObjects.pure() : super.pure(_defaultValue);
  const NumberOfObjects.dirty([int value = _defaultValue]) : super.dirty(value);

  static const int _defaultValue = 4;
  static const int _minValue = 1;
  static const int _maxValue = 24;

  @override
  NumberOfObjectsValidationError? validator(int? value) {
    return (value != null && value >= _minValue && value <= _maxValue)
        ? null
        : NumberOfObjectsValidationError.invalid;
  }
}
