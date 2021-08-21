import 'dart:collection';

import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/core/core.dart';
import 'package:prechac_this/patterns_repository/models/throwable.dart';

abstract class Patternable<P extends Patternable<P, T>, T extends Throwable>
    with Comparable<P>, Compare<P>, EquatableMixin, IterableMixin<T> {
  Patternable({
    required this.numberOfJugglers,
    required this.throwSequence,
  });

  final int numberOfJugglers;
  final List<T> throwSequence;

  late int period = _getPeriod();
  int _getPeriod() {
    return throwSequence.length;
  }

  late Fraction prechator = _getPrechator();
  Fraction _getPrechator() {
    return Fraction(period, numberOfJugglers).reduce();
  }

  Fraction timeBetweenThrows() {
    final fractionalPart = prechator.toMixedFraction().fractionalPart;
    return fractionalPart > Fraction(0) ? fractionalPart : Fraction(1);
  }

  late int numberOfPasses = _getNumberOfPasses();
  int _getNumberOfPasses() {
    var numberOfPasses = 0;
    for (final aThrow in this) {
      if (aThrow.isPass) {
        numberOfPasses++;
      }
    }
    return numberOfPasses;
  }

  P normalize() {
    return allRotations().max()!;
  }

  P rotate([int numberOfThrows = 1]);

  List<P> allRotations() {
    final rotations = <P>[];
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
  List<Object?> get props => [numberOfJugglers, throwSequence];

  @override
  String toString() {
    final components = map(
      (aThrow) => aThrow.toStringShowingPassingIndex(shouldShowPassingIndex),
    );
    return components.join(' ');
  }

  String throwAtIndexToString(int index) {
    final theThrow = throwAtIndex(index);
    return theThrow.toStringShowingPassingIndex(shouldShowPassingIndex);
  }

  bool get shouldShowPassingIndex {
    return numberOfJugglers > 2;
  }

  @override
  int compareTo(P other) {
    final numberOfJugglersComparator =
        numberOfJugglers.compareTo(other.numberOfJugglers);
    if (numberOfJugglersComparator != 0) {
      return numberOfJugglersComparator;
    }

    final periodComparator = period.compareTo(other.period);
    if (periodComparator != 0) {
      return periodComparator;
    }

    final numberOfPassesComparator =
        numberOfPasses.compareTo(other.numberOfPasses);
    if (numberOfPassesComparator != 0) {
      return numberOfPassesComparator;
    }

    var index = 0;
    for (final thisThrow in this) {
      final otherThrow = other.throwAtIndex(index);
      final throwComparator = thisThrow.compareTo(otherThrow);
      if (throwComparator != 0) {
        return throwComparator;
      }
      index++;
    }
    return 0;
  }

  @override
  Iterator<T> get iterator => throwSequence.iterator;

  Iterable<E> mapIndexedThrow<E>(E Function(int index, T item) f) sync* {
    var index = 0;

    for (final item in throwSequence) {
      yield f(index, item);
      index++;
    }
  }
}
