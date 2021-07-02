import 'package:formz/formz.dart';

import 'form_input_exception.dart';

class NumberOfObjects extends FormzInput<int, FormInputValidationException> {
  const NumberOfObjects.pure() : super.pure(defaultValue);
  const NumberOfObjects.dirty([int value = defaultValue]) : super.dirty(value);

  static const int defaultValue = 4;
  static const int minValue = 1;
  static const int maxValue = 24;

  @override
  FormInputValidationException? validator(int value) {
    if (value < minValue || value > maxValue) {
      return InputOutOfRangeException(
        'value should be between $minValue and $maxValue',
      );
    } else {
      return null;
    }
  }
}
