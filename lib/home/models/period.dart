import 'package:formz/formz.dart';

enum PeriodValidationError { invalid }

class Period extends FormzInput<int, PeriodValidationError> {
  const Period.pure() : super.pure(_defaultValue);
  const Period.dirty([int value = _defaultValue]) : super.dirty(value);

  static const int _defaultValue = 4;
  static const int _minValue = 1;
  static const int _maxValue = 24;

  @override
  PeriodValidationError? validator(int? value) {
    return (value != null && value >= _minValue && value <= _maxValue)
        ? null
        : PeriodValidationError.invalid;
  }
}
