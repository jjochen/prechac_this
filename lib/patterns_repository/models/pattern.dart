import 'package:fraction/fraction.dart';

import '../../core/core.dart';
import '../patterns_repository.dart';
import 'patternable.dart';
import 'throw.dart';

enum ThrowStyle { self, classic, equi, bi, instantbi }

class Pattern extends Patternable<Pattern, Throw> {
  Pattern({
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

  late Fraction numberOfObjects = _getNumberOfObjects();
  Fraction _getNumberOfObjects() {
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

  late String id = _getId();
  String _getId() {
    var components = <String>[]
      ..add(numberOfJugglers.toString())
      ..addAll(throwSequence.map((aThrow) => aThrow.id));
    return components.join(_idSeparator);
  }

  static const _idSeparator = '_';

  ThrowStyle styleOfThrowAtIndex(int index) {
    final theThrow = throwAtIndex(index);
    final origin = theThrow.origin;
    if (origin == null || theThrow.isSelf) {
      return ThrowStyle.self;
    }

    final ThrowStyle style;
    if (period.isEven) {
      if (origin.isEven) {
        style = ThrowStyle.equi;
      } else {
        style = ThrowStyle.classic;
      }
    } else {
      // period.isOdd
      if (origin.isEven == index.isEven) {
        style = ThrowStyle.instantbi;
      } else {
        style = ThrowStyle.bi;
      }
    }
    return style;
  }

  Iterable<E> mapThrowsAsStringWithStyle<E>(
      E Function(String string, ThrowStyle style) f) sync* {
    for (var index = 0; index < period; index++) {
      yield f(throwAtIndexToString(index), styleOfThrowAtIndex(index));
    }
  }
}
