import 'package:dartx/dartx.dart';

import '../../patterns_repository.dart';
import 'parser_throw_constraint.dart';

extension ParserPatternConstraint on PatternConstraint {
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
