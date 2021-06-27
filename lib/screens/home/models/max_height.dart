import 'package:formz/formz.dart';

enum MaxHeightValidationError { requiredFieldMissing, outOfRange }

class MaxHeight extends FormzInput<int, MaxHeightValidationError> {
  const MaxHeight.pure() : super.pure(defaultValue);
  const MaxHeight.dirty([int value = defaultValue]) : super.dirty(value);

  static const int defaultValue = 4;
  static const int minValue = 1;
  static const int maxValue = 24;

  @override
  MaxHeightValidationError? validator(int? value) {
    if (value == null) {
      return MaxHeightValidationError.requiredFieldMissing;
    } else if (value < minValue || value > maxValue) {
      return MaxHeightValidationError.outOfRange;
    } else {
      return null;
    }
  }
}
