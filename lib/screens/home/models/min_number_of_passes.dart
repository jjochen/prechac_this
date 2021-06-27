import 'package:formz/formz.dart';

enum MinNumberOfPassesValidationError { outOfRange }

class MinNumberOfPasses
    extends FormzInput<int?, MinNumberOfPassesValidationError> {
  const MinNumberOfPasses.pure() : super.pure(defaultValue);
  const MinNumberOfPasses.dirty([int? value = defaultValue])
      : super.dirty(value);

  static const int? defaultValue = null;
  static const int minValue = 0;
  static const int maxValue = 24;

  @override
  MinNumberOfPassesValidationError? validator(int? value) {
    if (value != null && (value < minValue || value > maxValue)) {
      return MinNumberOfPassesValidationError.outOfRange;
    } else {
      return null;
    }
  }
}
