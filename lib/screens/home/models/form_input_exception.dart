import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FormInputValidationException
    with EquatableMixin
    implements Exception {
  const FormInputValidationException();
}

class InputOutOfRangeException extends FormInputValidationException {
  const InputOutOfRangeException(this.minValue, this.maxValue) : super();

  final num minValue;
  final num maxValue;

  @override
  List<Object> get props => [minValue, maxValue];
}
