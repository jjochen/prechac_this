import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:prechac_this/screens/home/home.dart';

@immutable
class MaxHeight extends FormzInput<int, FormInputValidationException> {
  const MaxHeight.pure() : super.pure(defaultValue);
  const MaxHeight.dirty([int value = defaultValue]) : super.dirty(value);

  static const int defaultValue = 4;
  static const int minValue = 1;
  static const int maxValue = 12;

  @override
  FormInputValidationException? validator(int value) {
    if (value < minValue || value > maxValue) {
      return const InputOutOfRangeException(minValue, maxValue);
    } else {
      return null;
    }
  }
}
