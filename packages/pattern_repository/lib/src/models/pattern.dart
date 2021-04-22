import 'dart:collection';
import 'package:equatable/equatable.dart';

import 'throw.dart';

class Pattern with EquatableMixin, IterableMixin<Throw> {
  const Pattern(this._sequence);

  final List<Throw> _sequence;

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
  Iterator<Throw> get iterator => _sequence.iterator;

  Iterable<E> mapIndexedThrows<E>(E Function(int index, Throw item) f) sync* {
    var index = 0;

    for (final item in _sequence) {
      yield f(index, item);
      index = index + 1;
    }
  }

  Throw throwAtIndex(int index) {
    return _sequence[index];
  }

  Pattern copyWithThow({
    required Throw newThrow,
    required int index,
  }) {
    var newSequence = List<Throw>.from(_sequence);
    newSequence[index] = newThrow;
    return Pattern(newSequence);
  }
}
