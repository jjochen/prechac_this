import 'package:formz/formz.dart';

enum MaxHeightValidationError { invalid }

class MaxHeight extends FormzInput<int, MaxHeightValidationError> {
  const MaxHeight.pure() : super.pure(_defaultValue);
  const MaxHeight.dirty([int value = _defaultValue]) : super.dirty(value);

  static const int _defaultValue = 4;
  static const int _minValue = 1;
  static const int _maxValue = 24;

  @override
  MaxHeightValidationError? validator(int? value) {
    return (value != null && value >= _minValue && value <= _maxValue)
        ? null
        : MaxHeightValidationError.invalid;
  }
}
