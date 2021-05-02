import 'dart:collection';

import 'package:fraction/fraction.dart';

import '../core/core.dart';
import 'patternable.dart';
import 'throw.dart';

class Pattern extends Patternable
    with Comparable<Pattern>, Compare<Pattern>, IterableMixin<Throw> {
  const Pattern(this.throwSequence);

  @override
  final List<Throw> throwSequence;

  @override
  int compareTo(Pattern other) {
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
  String toString() {
    final components = map((e) => e.toString());
    return '${components.join(', ')}';
  }

  int get period {
    return throwSequence.length;
  }

  Fraction averageNumberOfObjectsPerJuggler() {
    var sumOfHeights = 0.toFraction();
    for (var aThrow in this) {
      sumOfHeights += aThrow.height;
    }

    return (sumOfHeights / Fraction(period)).reduce();
  }

  Pattern normalize() {
    return allRotations()
        .reduce((value, element) => element > value ? element : value);
  }

  Pattern rotate([int numberOfThrows = 1]) {
    return Pattern(throwSequence.rotate(numberOfThrows));
  }

  List<Pattern> allRotations() {
    var rotations = <Pattern>[];
    for (var i = 0; i < period; i++) {
      rotations.add(rotate(i));
    }
    return rotations;
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
  Iterator<Throw> get iterator => throwSequence.iterator;

  Iterable<E> mapIndexedThrow<E>(E Function(int index, Throw item) f) sync* {
    var index = 0;

    for (final item in throwSequence) {
      yield f(index, item);
      index = index + 1;
    }
  }

  Throw throwAtIndex(int index) {
    return throwSequence[index];
  }

  Pattern copyWithThrow({
    required Throw newThrow,
    required int index,
  }) {
    var newSequence = List<Throw>.from(throwSequence);
    newSequence[index] = newThrow;
    return Pattern(newSequence);
  }
}
