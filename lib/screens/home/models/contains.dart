import 'package:formz/formz.dart';

import 'form_input_exception.dart';

class Contains extends FormzInput<String?, FormInputValidationException> {
  const Contains.pure() : super.pure(defaultValue);
  const Contains.dirty([String? value = defaultValue]) : super.dirty(value);

  static const String? defaultValue = null;

  @override
  FormInputValidationException? validator(String? value) {
    return null;
  }
}
