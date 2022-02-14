import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';
import 'package:prechac_this/core/core.dart';
import 'package:prechac_this/patterns_repository/constraint_parser/parser.dart';
import 'package:prechac_this/patterns_repository/engine/engine.dart';
import 'package:prechac_this/patterns_repository/models/models.dart';

export 'exceptions/pattern_repository_exception.dart';
export 'models/models.dart';
export 'pattern_information/pattern_information.dart';

class PatternsRepository {
  const PatternsRepository({required this.computer});

  final Computer<SearchParameters, List<Pattern>> computer;

  Future<List<Pattern>> findPatterns({
    required SearchParameters parameters,
  }) {
    return computer.run(findPatternsSync, parameters);
  }

  @visibleForTesting
  static List<Pattern> findPatternsSync(SearchParameters parameters) {
    final constraints = parameters.parse();
    const engine = Engine();
    return engine.fillConstraint(patternConstraint: constraints);
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
