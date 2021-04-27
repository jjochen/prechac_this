import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:fraction/fraction.dart';

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

  Fraction averageNumberOfObjectsPerJuggler() {
    var sumOfHeights = 0.toFraction();
    for (var aThrow in this) {
      sumOfHeights += aThrow.height;
    }

    return (sumOfHeights / Fraction(period)).reduce();
  }

  int numberOfPasses() {
    var numberOfPasses = 0;
    for (var aThrow in this) {
      if (aThrow.isPass) {
        numberOfPasses++;
      }
    }
    return numberOfPasses;
  }

  @override
  Iterator<Throw> get iterator => _sequence.iterator;

  Iterable<E> mapIndexedThrow<E>(E Function(int index, Throw item) f) sync* {
    var index = 0;

    for (final item in _sequence) {
      yield f(index, item);
      index = index + 1;
    }
  }

  Throw throwAtIndex(int index) {
    return _sequence[index];
  }

  Pattern copyWithThrow({
    required Throw newThrow,
    required int index,
  }) {
    var newSequence = List<Throw>.from(_sequence);
    newSequence[index] = newThrow;
    return Pattern(newSequence);
  }
}
