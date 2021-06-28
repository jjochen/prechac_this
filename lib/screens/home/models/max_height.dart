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

  String? get errorText {
    final String? text;
    switch (error) {
      case MaxHeightValidationError.requiredFieldMissing:
        text = 'required field';
        break;
      case MaxHeightValidationError.outOfRange:
        text = 'value should be between $minValue and $maxValue';
        break;
      case null:
        text = null;
        break;
    }
    return text;
  }
}
