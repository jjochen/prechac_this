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

  String? get errorText {
    final String? text;
    switch (error) {
      case MaxNumberOfPassesValidationError.outOfRange:
        text = 'value should be between $minValue and $maxValue';
        break;
      case null:
        text = null;
        break;
    }
    return text;
  }
}
