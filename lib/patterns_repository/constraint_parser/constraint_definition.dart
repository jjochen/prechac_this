import 'package:petitparser/petitparser.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

class ConstraintParserDefinition extends GrammarDefinition {
  @override
  Parser start() => ref0(throwConstraint).end();

  Parser<ThrowConstraint> throwConstraint() =>
      (self() | pass() | throwPlaceholder()).map((value) => value);

  Parser<ThrowConstraint> self() =>
      integer().map((height) => ThrowConstraint.self(height: height));

  Parser<ThrowConstraint> pass() =>
      (floatOrPlaceholder() & passMarker() & integerOrPlaceholder())
          .map((values) => ThrowConstraint.pass(
                height: values[0],
                passingIndex: values[2],
              ));

  Parser<ThrowConstraint> throwPlaceholder() =>
      placeholder().map((_) => ThrowConstraint.placeholder());

  Parser<int> integer() => digits().flatten().map(int.parse);
  Parser<int?> integerOrPlaceholder() =>
      (integer() | integerPlaceholder()).map((value) => value);
  Parser<int?> integerPlaceholder() => placeholder().map((value) => null);

  Parser<double> float() =>
      (digits() & (decimalSeparator() & digits()).optional())
          .flatten()
          .map(double.parse);
  Parser<double?> floatOrPlaceholder() =>
      (float() | floatPlaceholder()).map((value) => value);
  Parser<double?> floatPlaceholder() => placeholder().map((value) => null);

  Parser digits() => digit().plus();
  Parser passMarker() => pattern('pP');
  Parser placeholder() => pattern('_?*');
  Parser decimalSeparator() => pattern('.,');
}
