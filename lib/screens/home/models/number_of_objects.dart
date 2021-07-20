import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import 'form_input_exception.dart';

@immutable
class NumberOfObjects extends FormzInput<int, FormInputValidationException> {
  const NumberOfObjects.pure() : super.pure(defaultValue);
  const NumberOfObjects.dirty([int value = defaultValue]) : super.dirty(value);

  static const int defaultValue = 4;
  static const int minValue = 1;
  static const int maxValue = 42;

  @override
  FormInputValidationException? validator(int value) {
    if (value < minValue || value > maxValue) {
      return const InputOutOfRangeException(minValue, maxValue);
    } else {
      return null;
    }
  }
}
