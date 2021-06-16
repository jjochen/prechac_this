import 'package:dartx/dartx.dart';
import 'package:petitparser/petitparser.dart';

import '../patterns_repository.dart';

class ConstraintParserDefinition extends GrammarDefinition {
  @override
  Parser start() => (throwSequence() | emptyList()).end();

  Parser<List<ThrowConstraint>> emptyList() =>
      whitespace().optional().map((_) => <ThrowConstraint>[]);

  Parser<List<ThrowConstraint>> throwSequence() =>
      (throwConstraint() & whitespaceAndThrowConstraint().star())
          .trim()
          .map((values) => <ThrowConstraint>[values[0], ...values[1]]);

  Parser<ThrowConstraint> whitespaceAndThrowConstraint() =>
      (whitespace().plus() & throwConstraint()).map((values) => values.last);

  Parser<ThrowConstraint> throwConstraint() => [
        pass(),
        throwPlaceholder(),
        self(),
      ]
          .toChoiceParser(failureJoiner: selectFarthestJoined)
          .map((value) => value);

  // TODO: handle case where self is expressed as _p0
  Parser<ThrowConstraint> self() =>
      integer().map((height) => ThrowConstraint.self(height: height));

  Parser<ThrowConstraint> pass() => (floatOrPlaceholder() & passingIndex())
      .map((values) => ThrowConstraint.pass(
            height: values.elementAt(0),
            passingIndex: values.elementAt(1),
          ));

  Parser<int?> passingIndex() =>
      (pWithIndex() | pWithoutIndex()).map((value) => value);

  Parser<int?> pWithIndex() => (passMarker() & integerOrPlaceholder())
      .map((values) => values.elementAtOrNull(1));
  Parser<int?> pWithoutIndex() => passMarker().map((_) => null);

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
