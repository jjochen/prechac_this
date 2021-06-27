import 'package:formz/formz.dart';

enum MaxNumberOfPassesValidationError { outOfRange }

class MaxNumberOfPasses
    extends FormzInput<int?, MaxNumberOfPassesValidationError> {
  const MaxNumberOfPasses.pure() : super.pure(defaultValue);
  const MaxNumberOfPasses.dirty([int? value = defaultValue])
      : super.dirty(value);

  static const int? defaultValue = null;
  static const int minValue = 0;
  static const int maxValue = 24;

  @override
  MaxNumberOfPassesValidationError? validator(int? value) {
    if (value != null && (value < minValue || value > maxValue)) {
      return MaxNumberOfPassesValidationError.outOfRange;
    } else {
      return null;
    }
  }
}
