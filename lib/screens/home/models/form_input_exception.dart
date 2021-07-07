import 'package:equatable/equatable.dart';

abstract class FormInputValidationException
    with EquatableMixin
    implements Exception {
  const FormInputValidationException();
}

class InputOutOfRangeException extends FormInputValidationException {
  InputOutOfRangeException(this.minValue, this.maxValue) : super();

  final num minValue;
  final num maxValue;

  @override
  List<Object> get props => [minValue, maxValue];
}
