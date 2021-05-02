import '../core/core.dart';
import 'patternable.dart';
import 'throw_constraint.dart';

class PatternConstraint
    extends Patternable<PatternConstraint, ThrowConstraint> {
  const PatternConstraint(List<ThrowConstraint> throwSequence)
      : super(throwSequence);

  @override
  PatternConstraint rotate([int numberOfThrows = 1]) {
    return PatternConstraint(throwSequence.rotate(numberOfThrows));
  }

  @override
  PatternConstraint copyWithThrow({
    required ThrowConstraint newThrow,
    required int index,
  }) {
    var newSequence = List<ThrowConstraint>.from(throwSequence);
    newSequence[index] = newThrow;
    return PatternConstraint(newSequence);
  }
}
