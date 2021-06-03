import 'dart:collection';

import 'package:equatable/equatable.dart';

import '../core/core.dart';
import 'throwable.dart';

abstract class Patternable<P extends Patternable<P, T>, T extends Throwable>
    with Comparable<P>, Compare<P>, EquatableMixin, IterableMixin<T> {
  const Patternable(this.throwSequence);

  final List<T> throwSequence;

  int get period {
    return throwSequence.length;
  }

  P normalize() {
    return allRotations()
        .reduce((value, element) => element > value ? element : value);
  }

  P rotate([int numberOfThrows = 1]);

  List<P> allRotations() {
    var rotations = <P>[];
    for (var i = 0; i < period; i++) {
      rotations.add(rotate(i));
    }
    return rotations;
  }

  T throwAtIndex(int index) {
    return throwSequence[index];
  }

  P copyWithThrow({
    required T newThrow,
    required int index,
  });

  @override
  List<Object?> get props => [throwSequence];

  @override
  String toString() {
    final components = map((e) => e.toString());
    return '${components.join(', ')}';
  }

  @override
  int compareTo(P other) {
    final periodComparator = period.compareTo(other.period);
    if (periodComparator != 0) {
      return periodComparator;
    }

    var index = 0;
    for (var thisThrow in this) {
      final otherThrow = other.throwAtIndex(index);
      final throwComparator = thisThrow.compareTo(otherThrow);
      if (throwComparator != 0) {
        return throwComparator;
      }
    }
    return 0;
  }

  @override
  Iterator<T> get iterator => throwSequence.iterator;

  Iterable<E> mapIndexedThrow<E>(E Function(int index, T item) f) sync* {
    var index = 0;

    for (final item in throwSequence) {
      yield f(index, item);
      index = index + 1;
    }
  }
}
