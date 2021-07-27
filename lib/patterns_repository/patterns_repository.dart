import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';

import '../core/core.dart';
import 'constraint_parser/parser.dart';
import 'engine/engine.dart';
import 'models/models.dart';

export 'exceptions/pattern_repository_exception.dart';
export 'models/models.dart';

class PatternsRepository {
  const PatternsRepository({required this.computer});

  final Computer<SearchParameters, List<Pattern>> computer;

  Future<List<Pattern>> patterns(SearchParameters parameters) async {
    return await computer.run(findPatterns, parameters);
  }

  @visibleForTesting
  static List<Pattern> findPatterns(SearchParameters parameters) {
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
