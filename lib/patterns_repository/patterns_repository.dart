import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/constraint_parser/constraint_parser.dart';

import 'engine/engine.dart';
import 'models/models.dart';

export 'models/models.dart';

class PatternsRepository {
  Future<List<Pattern>> patterns(SearchParameters parameters) async {
    return await compute(findPatterns, parameters);
  }

  static List<Pattern> findPatterns(SearchParameters parameters) {
    const engine = Engine();
    final constraints = patternConstraintFromSearchParameters(parameters);
    return engine.fillConstraint(patternConstraint: constraints);
  }

  static PatternConstraint patternConstraintFromSearchParameters(
    SearchParameters parameters,
  ) {
    final minNumberOfPasses =
        parameters.minNumberOfPasses < 0 ? 1 : parameters.minNumberOfPasses;
    final maxNumberOfPasses = parameters.maxNumberOfPasses < 0
        ? parameters.period
        : parameters.maxNumberOfPasses;

    final parser = ConstraintParserDefinition().build();
    List<ThrowConstraint> contains = parser.parse(parameters.contains).value;

    var throwSequence = List.filled(
      parameters.period,
      ThrowConstraint.placeholder(),
    );
    contains.forEachIndexed((throwConstraint, index) {
      final indexInSequence = index % throwSequence.length;
      final existingConstraint = throwSequence[indexInSequence];
      final newConstraint = existingConstraint.merge(throwConstraint);
      throwSequence[indexInSequence] = newConstraint;
    });

    final patternConstraint = PatternConstraint(
      numberOfJugglers: parameters.numberOfJugglers,
      numberOfObjects: parameters.numberOfObjects,
      maxHeight: parameters.maxHeight,
      minNumberOfPasses: minNumberOfPasses,
      maxNumberOfPasses: maxNumberOfPasses,
      throwSequence: throwSequence,
    );
    return patternConstraint;
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
