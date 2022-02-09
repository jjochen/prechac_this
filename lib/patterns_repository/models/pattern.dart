import 'package:fraction/fraction.dart';
import 'package:prechac_this/core/core.dart';
import 'package:prechac_this/patterns_repository/models/patternable.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

enum ThrowStyle { self, classic, equi, bi, instantBi }

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
    final newSequence = List<Throw>.from(throwSequence);
    newSequence[index] = newThrow;
    return Pattern(
      numberOfJugglers: numberOfJugglers,
      throwSequence: newSequence,
    );
  }

  late Fraction numberOfObjects = _getNumberOfObjects();
  Fraction _getNumberOfObjects() {
    var sumOfHeights = 0.toFraction();
    for (final aThrow in this) {
      sumOfHeights += aThrow.height;
    }

    return (sumOfHeights / prechator).reduce();
  }

  static Pattern? fromId(String id) {
    final components = id.split(_idSeparator);

    final int numberOfJugglers;
    final throwSequence = <Throw>[];
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
    final components = <String>[
      numberOfJugglers.toString(),
      ...throwSequence.map((aThrow) => aThrow.id)
    ];
    return components.join(_idSeparator);
  }

  static const _idSeparator = '_';

  ThrowStyle styleOfThrowAtIndex(int index) {
    final theThrow = throwAtIndex(index);
    if (theThrow.isSelf) {
      return ThrowStyle.self;
    }

    final originFraction =
        (theThrow.height - (theThrow.passingIndex.toFraction() * prechator))
            .reduce();
    assert(originFraction.isWhole, 'originFraction is not whole');
    final origin = originFraction.numerator;
    final passingIndex = theThrow.passingIndex;

    final ThrowStyle style;
    if (period.isEven) {
      if (origin.isEven) {
        style = ThrowStyle.equi;
      } else {
        style = ThrowStyle.classic;
      }
    } else {
      // period.isOdd
      if (origin.isOdd == passingIndex.isOdd) {
        style = ThrowStyle.bi;
      } else {
        style = ThrowStyle.instantBi;
      }
    }
    return style;
  }

  Iterable<E> mapThrowsAsStringWithStyle<E>(
    E Function(String string, ThrowStyle style) f,
  ) sync* {
    for (var index = 0; index < period; index++) {
      yield f(throwAtIndexToString(index), styleOfThrowAtIndex(index));
    }
  }
}
