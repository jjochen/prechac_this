import 'package:fraction/fraction.dart';

import '../core/core.dart';
import 'patternable.dart';
import 'throw.dart';

class Pattern extends Patternable<Pattern, Throw> {
  const Pattern(List<Throw> throwSequence) : super(throwSequence);

  @override
  Pattern rotate([int numberOfThrows = 1]) {
    return Pattern(throwSequence.rotate(numberOfThrows));
  }

  @override
  Pattern copyWithThrow({
    required Throw newThrow,
    required int index,
  }) {
    var newSequence = List<Throw>.from(throwSequence);
    newSequence[index] = newThrow;
    return Pattern(newSequence);
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

  static Pattern? fromId(String id) {
    final components = id.split(_idSeparator);
    var throwSequence = <Throw>[];
    for (final throwId in components) {
      final nextThrow = Throw.fromId(throwId);
      if (nextThrow == null) {
        return null;
      }
      throwSequence.add(nextThrow);
    }
    return Pattern(throwSequence);
  }

  String get id {
    return throwSequence.map((aThrow) => aThrow.id).join(_idSeparator);
  }

  static const _idSeparator = '_';
}
