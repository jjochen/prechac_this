import 'dart:async';

import 'package:pattern_repository/src/engine/engine.dart';

import 'models/models.dart';

class PatternRepository {
  Stream<List<Pattern>> patterns({
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
      ThrowConstraint.placeholder(),
      ThrowConstraint.placeholder(),
      ThrowConstraint.placeholder(),
      ThrowConstraint.placeholder(),
    ]);
    return engine.fillConstraint(patternConstraint: patternConstraint);
  }

  // Pattern prechacThisThrowConstraint({
  //   required Pattern pattern,
  //   required int index,
  //   required PrechacDirection direction,
  //   required int numberOfJugglers,
  // }) {
  //   return pattern;
  //   final oldThrow = patternConstraint.throwConstraintAtIndex(index);
  //   final oldHeight = oldThrowConstraint.height;
  //   final oldPassingIndex = oldThrowConstraint.passingIndex;
  //   final prechator = patternConstraint.period / numberOfJugglers;
  //   if (oldHeight == null || oldPassingIndex == null) {
  //     // TODO: throw exception
  //     // maybe separate Throw and Throw
  //     return pattern;
  //   }

  //   double newHeight;
  //   double newPassingIndex;

  //   final newHeight = oldHeight + prechator;
  //   final newPassingIndex =
  //   return patternConstraint.copyWithThrowConstraint(
  //     newThrowConstraint: newThrowConstraint,
  //     index: index,
  //   );
  // }
}
