import 'package:petitparser/petitparser.dart';
import 'package:prechac_this/patterns_repository/constraint_parser/constraint_parser_definition.dart';
import 'package:prechac_this/patterns_repository/constraint_parser/extensions/parser_pattern_constraint.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

extension ParserSearchParameters on SearchParameters {
  int get unwrappedMinNumberOfPasses =>
      minNumberOfPasses < 0 ? 1 : minNumberOfPasses;
  int get unwrappedMaxNumberOfPasses =>
      maxNumberOfPasses < 0 ? period : maxNumberOfPasses;

  PatternConstraint parse() {
    final parser = ConstraintParserDefinition().build();
    final List<ThrowConstraint> throwSequence;
    try {
      throwSequence = parser.parse(contains).value;
    } on ParserException catch (e) {
      throw ConstraintsInvalidException(e.failure.message);
    }

    final patternConstraint = PatternConstraint.placeholder(
      numberOfJugglers: numberOfJugglers,
      period: period,
      numberOfObjects: numberOfObjects,
      maxHeight: maxHeight,
      minNumberOfPasses: unwrappedMinNumberOfPasses,
      maxNumberOfPasses: unwrappedMaxNumberOfPasses,
    );

    return patternConstraint.mergeThrowSequence(throwSequence);
  }
}
