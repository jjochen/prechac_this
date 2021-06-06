import '../../core/core.dart';
import 'patternable.dart';
import 'throw_constraint.dart';

class PatternConstraint
    extends Patternable<PatternConstraint, ThrowConstraint> {
  PatternConstraint({
    required int numberOfJugglers,
    required List<ThrowConstraint> throwSequence,
  }) : super(
          numberOfJugglers: numberOfJugglers,
          throwSequence: throwSequence,
        );

  @override
  PatternConstraint rotate([int numberOfThrows = 1]) {
    return PatternConstraint(
      numberOfJugglers: numberOfJugglers,
      throwSequence: throwSequence.rotate(numberOfThrows),
    );
  }

  @override
  PatternConstraint copyWithThrow({
    required ThrowConstraint newThrow,
    required int index,
  }) {
    var newSequence = List<ThrowConstraint>.from(throwSequence);
    newSequence[index] = newThrow;
    return PatternConstraint(
      numberOfJugglers: numberOfJugglers,
      throwSequence: newSequence,
    );
  }
}
