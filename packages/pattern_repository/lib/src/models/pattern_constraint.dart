import 'dart:collection';
import 'package:equatable/equatable.dart';

import 'throw_constraint.dart';

class PatternConstraint with EquatableMixin, IterableMixin<ThrowConstraint> {
  const PatternConstraint(this._sequence);

  final List<ThrowConstraint> _sequence;

  @override
  List<Object?> get props => [_sequence];

  @override
  String toString() {
    final components = map((e) => e.toString());
    return '${components.join(', ')}';
  }

  int get period {
    return _sequence.length;
  }

  @override
  Iterator<ThrowConstraint> get iterator => _sequence.iterator;

  Iterable<E> mapIndexedThrowConstraint<E>(
      E Function(int index, ThrowConstraint item) f) sync* {
    var index = 0;

    for (final item in _sequence) {
      yield f(index, item);
      index = index + 1;
    }
  }

  ThrowConstraint throwConstraintAtIndex(int index) {
    return _sequence[index];
  }

  PatternConstraint copyWithThrowConstraint({
    required ThrowConstraint newThrowConstraint,
    required int index,
  }) {
    var newSequence = List<ThrowConstraint>.from(_sequence);
    newSequence[index] = newThrowConstraint;
    return PatternConstraint(newSequence);
  }
}
