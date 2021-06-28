import 'package:formz/formz.dart';

enum ContainsValidationError { invalid }

class Contains extends FormzInput<String?, ContainsValidationError> {
  const Contains.pure() : super.pure(defaultValue);
  const Contains.dirty([String? value = defaultValue]) : super.dirty(value);

  static const String? defaultValue = null;

  @override
  ContainsValidationError? validator(String? value) {
    return null;
  }

  String? get errorText {
    final String? text;
    switch (error) {
      case ContainsValidationError.invalid:
        text = 'invalid';
        break;
      case null:
        text = null;
        break;
    }
    return text;
  }
}
