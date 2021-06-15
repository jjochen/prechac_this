import '../../core/core.dart';
import 'patternable.dart';
import 'throw_constraint.dart';

class PatternConstraint
    extends Patternable<PatternConstraint, ThrowConstraint> {
  PatternConstraint({
    required int numberOfJugglers,
    required this.numberOfObjects,
    required this.maxHeight,
    required this.minNumberOfPasses,
    required this.maxNumberOfPasses,
    required List<ThrowConstraint> throwSequence,
  }) : super(
          numberOfJugglers: numberOfJugglers,
          throwSequence: throwSequence,
        );

  final int numberOfObjects;
  final int maxHeight;
  final int minNumberOfPasses;
  final int maxNumberOfPasses;

  @override
  List<Object?> get props => [
        numberOfJugglers,
        numberOfObjects,
        maxHeight,
        minNumberOfPasses,
        maxNumberOfPasses,
        throwSequence,
      ];

  PatternConstraint copyWith({
    int? numberOfJugglers,
    int? numberOfObjects,
    int? maxHeight,
    int? minNumberOfPasses,
    int? maxNumberOfPasses,
    List<ThrowConstraint>? throwSequence,
  }) {
    return PatternConstraint(
      numberOfJugglers: numberOfJugglers ?? this.numberOfJugglers,
      numberOfObjects: numberOfObjects ?? this.numberOfObjects,
      maxHeight: maxHeight ?? this.maxHeight,
      minNumberOfPasses: minNumberOfPasses ?? this.minNumberOfPasses,
      maxNumberOfPasses: maxNumberOfPasses ?? this.maxNumberOfPasses,
      throwSequence: throwSequence ?? this.throwSequence,
    );
  }

  @override
  PatternConstraint copyWithThrow({
    required ThrowConstraint newThrow,
    required int index,
  }) {
    var newSequence = List<ThrowConstraint>.from(throwSequence);
    newSequence[index] = newThrow;
    return copyWith(
      throwSequence: newSequence,
    );
  }

  @override
  PatternConstraint rotate([int numberOfThrows = 1]) {
    return copyWith(
      throwSequence: throwSequence.rotate(numberOfThrows),
    );
  }
}
