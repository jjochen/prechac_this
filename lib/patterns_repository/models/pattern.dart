import 'package:fraction/fraction.dart';

import '../core/core.dart';
import 'patternable.dart';
import 'throw.dart';

class Pattern extends Patternable<Pattern, Throw> {
  const Pattern({
    required int numberOfJugglers,
    required List<Throw> throwSequence,
  }) : super(
          numberOfJugglers: numberOfJugglers,
          throwSequence: throwSequence,
        );

  @override
  Pattern rotate([int numberOfThrows = 1]) {
    return Pattern(
      numberOfJugglers: numberOfJugglers,
      throwSequence: throwSequence.rotate(numberOfThrows),
    );
  }

  @override
  Pattern copyWithThrow({
    required Throw newThrow,
    required int index,
  }) {
    var newSequence = List<Throw>.from(throwSequence);
    newSequence[index] = newThrow;
    return Pattern(
      numberOfJugglers: numberOfJugglers,
      throwSequence: newSequence,
    );
  }

  Fraction get numberOfObjects {
    var sumOfHeights = 0.toFraction();
    for (var aThrow in this) {
      sumOfHeights += aThrow.height;
    }

    return (sumOfHeights / prechator).reduce();
  }

  static Pattern? fromId(String id) {
    final components = id.split(_idSeparator);

    final int numberOfJugglers;
    var throwSequence = <Throw>[];
    try {
      numberOfJugglers = int.parse(components.removeAt(0));
      for (final throwId in components) {
        final nextThrow = Throw.fromId(throwId);
        if (nextThrow == null) {
          return null;
        }
        throwSequence.add(nextThrow);
      }
    } catch (e) {
      return null;
    }

    return Pattern(
      numberOfJugglers: numberOfJugglers,
      throwSequence: throwSequence,
    );
  }

  String get id {
    var components = <String>[]
      ..add(numberOfJugglers.toString())
      ..addAll(throwSequence.map((aThrow) => aThrow.id));
    return components.join(_idSeparator);
  }

  static const _idSeparator = '_';
}
