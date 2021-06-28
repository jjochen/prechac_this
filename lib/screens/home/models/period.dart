import 'package:formz/formz.dart';

enum PeriodValidationError { requiredFieldMissing, outOfRange }

class Period extends FormzInput<int, PeriodValidationError> {
  const Period.pure() : super.pure(defaultValue);
  const Period.dirty([int value = defaultValue]) : super.dirty(value);

  static const int defaultValue = 4;
  static const int minValue = 1;
  static const int maxValue = 24;

  @override
  PeriodValidationError? validator(int? value) {
    if (value == null) {
      return PeriodValidationError.requiredFieldMissing;
    } else if (value < minValue || value > maxValue) {
      return PeriodValidationError.outOfRange;
    } else {
      return null;
    }
  }

  String? get errorText {
    final String? text;
    switch (error) {
      case PeriodValidationError.requiredFieldMissing:
        text = 'required field';
        break;
      case PeriodValidationError.outOfRange:
        text = 'value should be between $minValue and $maxValue';
        break;
      case null:
        text = null;
        break;
    }
    return text;
  }
}
