import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:prechac_this/screens/home/home.dart';

@immutable
class MinNumberOfPasses extends FormzInput<int?, FormInputValidationException> {
  const MinNumberOfPasses.pure() : super.pure(defaultValue);
  const MinNumberOfPasses.dirty([int? value = defaultValue])
      : super.dirty(value);

  static const int defaultValue = 1;
  static const int minValue = 0;
  static const int maxValue = 12;

  @override
  FormInputValidationException? validator(int? value) {
    if (value != null && (value < minValue || value > maxValue)) {
      return const InputOutOfRangeException(minValue, maxValue);
    } else {
      return null;
    }
  }
}
