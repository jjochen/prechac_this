import 'package:equatable/equatable.dart';

abstract class FormInputValidationException
    with EquatableMixin
    implements Exception {
  const FormInputValidationException(this.message);

  final String message;

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    final type = runtimeType.toString();
    if (message.isEmpty) {
      return type;
    }
    return '$type: $message';
  }
}

class InputOutOfRangeException extends FormInputValidationException {
  InputOutOfRangeException(String message) : super(message);
}
