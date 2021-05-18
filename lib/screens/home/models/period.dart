import 'package:formz/formz.dart';

enum PeriodValidationError { invalid }

class Period extends FormzInput<int, PeriodValidationError> {
  const Period.pure() : super.pure(defaultValue);
  const Period.dirty([int value = defaultValue]) : super.dirty(value);

  static const int defaultValue = 4;
  static const int minValue = 1;
  static const int maxValue = 24;

  @override
  PeriodValidationError? validator(int? value) {
    return (value != null && value >= minValue && value <= maxValue)
        ? null
        : PeriodValidationError.invalid;
  }
}
