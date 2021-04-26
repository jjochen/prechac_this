import 'dart:collection';
import 'package:equatable/equatable.dart';

import 'throw_constraints.dart';

class PatternConstraints with EquatableMixin, IterableMixin<ThrowConstraints> {
  const PatternConstraints(this._sequence);

  final List<ThrowConstraints> _sequence;

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
  Iterator<ThrowConstraints> get iterator => _sequence.iterator;

  Iterable<E> mapIndexedThrowConstraints<E>(
      E Function(int index, ThrowConstraints item) f) sync* {
    var index = 0;

    for (final item in _sequence) {
      yield f(index, item);
      index = index + 1;
    }
  }

  ThrowConstraints throwConstraintsAtIndex(int index) {
    return _sequence[index];
  }

  PatternConstraints copyWithThrowConstraints({
    required ThrowConstraints newThrowConstraints,
    required int index,
  }) {
    var newSequence = List<ThrowConstraints>.from(_sequence);
    newSequence[index] = newThrowConstraints;
    return PatternConstraints(newSequence);
  }
}
