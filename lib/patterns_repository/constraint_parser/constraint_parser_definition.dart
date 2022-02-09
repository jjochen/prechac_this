import 'package:dartx/dartx.dart';
import 'package:petitparser/petitparser.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

class ConstraintParserDefinition extends GrammarDefinition {
  @override
  Parser<List<ThrowConstraint>> start() => throwSequenceOrEmptyList().end();

  Parser<List<ThrowConstraint>> throwSequenceOrEmptyList() =>
      (throwSequence() | emptyList())
          .map((dynamic value) => value as List<ThrowConstraint>);

  Parser<List<ThrowConstraint>> emptyList() =>
      whitespace().optional().map((_) => <ThrowConstraint>[]);

  Parser<List<ThrowConstraint>> throwSequence() =>
      (throwConstraint() & whitespaceAndThrowConstraint().star()).trim().map(
            (values) =>
                <ThrowConstraint>[values[0] as ThrowConstraint, ...values[1]],
          );

  Parser<ThrowConstraint> whitespaceAndThrowConstraint() =>
      (whitespace().plus() & throwConstraint())
          .map((values) => values.last as ThrowConstraint);

  Parser<ThrowConstraint> throwConstraint() => [
        pass(),
        throwPlaceholder(),
        self(),
      ]
          .toChoiceParser(failureJoiner: selectFarthestJoined)
          .map((value) => value);

  Parser<ThrowConstraint> self() =>
      integer().map((height) => ThrowConstraint.self(height: height));

  Parser<ThrowConstraint> pass() => (floatOrPlaceholder() & passingIndex()).map(
        (values) => ThrowConstraint.pass(
          height: values.elementAt(0) as double?,
          passingIndex: values.elementAt(1) as int?,
        ),
      );

  Parser<int?> passingIndex() =>
      (pWithIndex() | pWithoutIndex()).map((dynamic value) => value as int?);

  Parser<int?> pWithIndex() => (passMarker() & integerOrPlaceholder())
      .map((values) => values.elementAtOrNull(1) as int?);
  Parser<int?> pWithoutIndex() => passMarker().map((_) => null);

  Parser<ThrowConstraint> throwPlaceholder() =>
      placeholder().map((_) => ThrowConstraint.placeholder());

  Parser<int> integer() => digits().flatten().map(int.parse);
  Parser<int?> integerOrPlaceholder() =>
      (integer() | integerPlaceholder()).map((dynamic value) => value as int?);
  Parser<int?> integerPlaceholder() => placeholder().map((value) => null);

  Parser<double> float() =>
      (digits() & (decimalSeparator() & digits()).optional())
          .flatten()
          .map(double.parse);
  Parser<double?> floatOrPlaceholder() => (float() | floatPlaceholder())
      .map<double?>((dynamic value) => value as double?);
  Parser<double?> floatPlaceholder() => placeholder().map((value) => null);

  Parser<List<String>> digits() => digit().plus();
  Parser<String> passMarker() => pattern('pP');
  Parser<String> placeholder() => pattern('_?*');
  Parser<String> decimalSeparator() => pattern('.,');
}
