import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

import 'form_input_exception.dart';

@immutable
class MaxNumberOfPasses extends FormzInput<int?, FormInputValidationException> {
  const MaxNumberOfPasses.pure() : super.pure(defaultValue);
  const MaxNumberOfPasses.dirty([int? value = defaultValue])
      : super.dirty(value);

  static const int defaultValue = -1;
  static const int minValue = -1;
  static const int maxValue = 24;

  @override
  FormInputValidationException? validator(int? value) {
    if (value != null && (value < minValue || value > maxValue)) {
      return const InputOutOfRangeException(minValue, maxValue);
    } else {
      return null;
    }
  }
}
