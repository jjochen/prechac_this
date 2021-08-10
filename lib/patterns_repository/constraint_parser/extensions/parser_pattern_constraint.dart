import 'package:dartx/dartx.dart';
import 'package:prechac_this/patterns_repository/constraint_parser/extensions/parser_throw_constraint.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

extension ParserPatternConstraint on PatternConstraint {
  PatternConstraint mergeThrowSequence(List<ThrowConstraint> otherSequence) {
    final newThrowSequence = List<ThrowConstraint>.from(throwSequence);
    otherSequence.forEachIndexed((throwConstraint, index) {
      final indexInSequence = index % newThrowSequence.length;
      final existingConstraint = newThrowSequence[indexInSequence];
      final newConstraint = existingConstraint.merge(throwConstraint);
      newThrowSequence[indexInSequence] = newConstraint;
    });
    return copyWith(throwSequence: newThrowSequence);
  }
}
