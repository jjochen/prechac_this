import 'package:dartx/dartx.dart';

import '../../patterns_repository.dart';
import '../constraint_parser_definition.dart';
import 'parser_throw_constraint.dart';

extension ParserPatternConstraint on PatternConstraint {
  static PatternConstraint fromSearchParameters(SearchParameters parameters) {
    final minNumberOfPasses =
        parameters.minNumberOfPasses < 0 ? 1 : parameters.minNumberOfPasses;
    final maxNumberOfPasses = parameters.maxNumberOfPasses < 0
        ? parameters.period
        : parameters.maxNumberOfPasses;

    final parser = ConstraintParserDefinition().build();
    List<ThrowConstraint> contains = parser.parse(parameters.contains).value;

    final patternConstraint = PatternConstraint.placeholder(
      numberOfJugglers: parameters.numberOfJugglers,
      period: parameters.period,
      numberOfObjects: parameters.numberOfObjects,
      maxHeight: parameters.maxHeight,
      minNumberOfPasses: minNumberOfPasses,
      maxNumberOfPasses: maxNumberOfPasses,
    );

    return patternConstraint.mergeThrowSequence(contains);
  }

  PatternConstraint mergeThrowSequence(List<ThrowConstraint> otherSequence) {
    var newThrowSequence = List<ThrowConstraint>.from(throwSequence);
    otherSequence.forEachIndexed((throwConstraint, index) {
      final indexInSequence = index % newThrowSequence.length;
      final existingConstraint = newThrowSequence[indexInSequence];
      final newConstraint = existingConstraint.merge(throwConstraint);
      newThrowSequence[indexInSequence] = newConstraint;
    });
    return copyWith(throwSequence: newThrowSequence);
  }
}
