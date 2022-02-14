import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:prechac_this/home/home.dart';

@immutable
class Contains extends FormzInput<String?, FormInputValidationException> {
  const Contains.pure() : super.pure(defaultValue);
  const Contains.dirty([String? value = defaultValue]) : super.dirty(value);

  static const String? defaultValue = null;

  @override
  FormInputValidationException? validator(String? value) {
    return null;
  }
}
