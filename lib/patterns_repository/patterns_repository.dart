import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fraction/fraction.dart';

import 'engine/engine.dart';
import 'models/models.dart';

export 'models/models.dart';

class PatternsRepository {
  Future<List<Pattern>> patterns(SearchParameters parameters) async {
    return await compute(findPatterns, parameters);
  }

  static List<Pattern> findPatterns(SearchParameters parameters) {
    final minNumberOfPasses =
        parameters.minNumberOfPasses < 0 ? 1 : parameters.minNumberOfPasses;
    final maxNumberOfPasses = parameters.maxNumberOfPasses < 0
        ? parameters.period
        : parameters.maxNumberOfPasses;

    final engine = Engine(
      numberOfObjects: parameters.numberOfObjects,
      maxHeight: parameters.maxHeight,
      minNumberOfPasses: minNumberOfPasses,
      maxNumberOfPasses: maxNumberOfPasses,
    );
    final throwSequence = List.filled(
      parameters.period,
      ThrowConstraint.placeholder(),
    );
    final patternConstraint = PatternConstraint(
      numberOfJugglers: parameters.numberOfJugglers,
      throwSequence: throwSequence,
    );
    return engine.fillConstraint(patternConstraint: patternConstraint);
  }

  Pattern prechacThisThrow({
    required Pattern pattern,
    required int index,
    required PrechacDirection direction,
  }) {
    final numberOfJugglers = pattern.numberOfJugglers;
    final prechator = pattern.prechator;
    final oldThrow = pattern.throwAtIndex(index);
    final oldHeight = oldThrow.height;
    final oldPassingIndex = oldThrow.passingIndex;
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
