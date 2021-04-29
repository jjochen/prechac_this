import 'dart:async';

import 'package:fraction/fraction.dart';

import 'engine/engine.dart';
import 'models/models.dart';

class PatternRepository {
  Stream<Pattern> patterns({
    required int numberOfJugglers,
    required int period,
    required int numberOfObjects,
    required int maxHeight,
    int? minNumberOfPasses,
    int? maxNumberOfPasses,
  }) {
    final engine = Engine(
      numberOfJugglers: numberOfJugglers,
      period: period,
      numberOfObjects: numberOfObjects,
      maxHeight: maxHeight,
      minNumberOfPasses: minNumberOfPasses,
      maxNumberOfPasses: maxNumberOfPasses,
    );
    final patternConstraint = PatternConstraint([
      ThrowConstraint.self(height: 4),
      ThrowConstraint.placeholder(),
      ThrowConstraint.self(height: 1),
      ThrowConstraint.placeholder(),
    ]);
    return engine.fillConstraint(patternConstraint: patternConstraint);
  }

  Pattern prechacThisThrow({
    required Pattern pattern,
    required int index,
    required PrechacDirection direction,
    required int numberOfJugglers,
  }) {
    final oldThrow = pattern.throwAtIndex(index);
    final oldHeight = oldThrow.height;
    final oldPassingIndex = oldThrow.passingIndex;
    final prechator = Fraction(pattern.period, numberOfJugglers);
    final Fraction newHeight;
    final int newPassingIndex;
    if (direction == PrechacDirection.up) {
      newHeight = oldHeight + prechator;
      newPassingIndex = (oldPassingIndex + 1) % numberOfJugglers;
    } else {
      newHeight = oldHeight - prechator;
      newPassingIndex =
          oldPassingIndex == 0 ? numberOfJugglers - 1 : (oldPassingIndex - 1);
    }
    return pattern.copyWithThrow(
      newThrow: Throw(height: newHeight, passingIndex: newPassingIndex),
      index: index,
    );
  }
}
