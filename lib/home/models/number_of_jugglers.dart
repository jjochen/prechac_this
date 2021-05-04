import 'package:formz/formz.dart';

enum NumberOfJugglersValidationError { invalid }

class NumberOfJugglers
    extends FormzInput<int, NumberOfJugglersValidationError> {
  const NumberOfJugglers.pure() : super.pure(_defaultValue);
  const NumberOfJugglers.dirty([int value = _defaultValue])
      : super.dirty(value);

  static const int _defaultValue = 2;
  static const int _minValue = 1;
  static const int _maxValue = 24;

  @override
  NumberOfJugglersValidationError? validator(int? value) {
    return (value != null && value >= _minValue && value <= _maxValue)
        ? null
        : NumberOfJugglersValidationError.invalid;
  }
}
