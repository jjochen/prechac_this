import '../../patterns_repository.dart';
import '../constraint_parser_definition.dart';
import 'parser_pattern_constraint.dart';

extension ParserSearchParameters on SearchParameters {
  int get unwrappedMinNumberOfPasses =>
      minNumberOfPasses < 0 ? 1 : minNumberOfPasses;
  int get unwrappedMaxNumberOfPasses =>
      maxNumberOfPasses < 0 ? period : maxNumberOfPasses;

  PatternConstraint parse() {
    final parser = ConstraintParserDefinition().build();
    List<ThrowConstraint> throwSequence = parser.parse(contains).value;

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
