import 'dart:collection';
import 'package:equatable/equatable.dart';

import 'patternable.dart';
import 'throw_constraint.dart';

class PatternConstraint extends Patternable
    with EquatableMixin, IterableMixin<ThrowConstraint> {
  const PatternConstraint(this.throwSequence);

  @override
  final List<ThrowConstraint> throwSequence;

  @override
  List<Object?> get props => [throwSequence];

  @override
  String toString() {
    final components = map((e) => e.toString());
    return '${components.join(', ')}';
  }

  int get period {
    return throwSequence.length;
  }

  @override
  Iterator<ThrowConstraint> get iterator => throwSequence.iterator;

  Iterable<E> mapIndexedThrowConstraint<E>(
      E Function(int index, ThrowConstraint item) f) sync* {
    var index = 0;

    for (final item in throwSequence) {
      yield f(index, item);
      index = index + 1;
    }
  }

  ThrowConstraint throwConstraintAtIndex(int index) {
    return throwSequence[index];
  }

  PatternConstraint copyWithThrowConstraint({
    required ThrowConstraint newThrowConstraint,
    required int index,
  }) {
    var newSequence = List<ThrowConstraint>.from(throwSequence);
    newSequence[index] = newThrowConstraint;
    return PatternConstraint(newSequence);
  }
}
