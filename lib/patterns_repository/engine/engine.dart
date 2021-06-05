import 'package:fraction/fraction.dart';

import '../core/core.dart';
import '../models/models.dart';
import 'prechac_pattern.dart';
import 'prechac_pattern_constraint.dart';
import 'prechac_throw.dart';

class Engine {
  Engine({
    required this.numberOfObjects,
    required this.maxHeight,
    required this.minNumberOfPasses,
    required this.maxNumberOfPasses,
  });

  final int numberOfObjects;
  final int maxHeight;
  final int minNumberOfPasses;
  final int maxNumberOfPasses;

  List<Pattern> fillConstraint({required PatternConstraint patternConstraint}) {
    // * constraint pattern as input
    //   > 4 _ 1 _p1
    // * calculate missing landing sites
    //   > 1, 2
    // * permutate missing landing sites
    //   > 1, 2; 2, 1
    // * for each landing site: calculate all possible throws
    //   (fitting all throw constraints)
    //   > 1 (at 1): 0, 2p1, 4
    //   > 2 (at 3): 1p
    //   > 2 (at 1): 1, 3p1
    //   > 1 (at 3): 4p1
    // * combine with correct number of objects and passes
    //   > 4 2p1 1 1p1
    //   (second permutation has too many objects)

    final numberOfJugglers = patternConstraint.numberOfJugglers;
    var setOfPatterns = <Pattern>{};

    final permutations = patternConstraint.permutationsOfPossibleLandingSites();
    for (final landingSites in permutations) {
      final bagsOfPossibleThrows =
          patternConstraint.mapIndexedThrow((index, throwConstraint) {
        final throwConstraint = patternConstraint.throwAtIndex(index);
        final landingSite = landingSites[index];
        final numberOfJugglers = patternConstraint.numberOfJugglers;
        final period = patternConstraint.period;
        final prechator = patternConstraint.prechator;
        return possibleThrows(
          throwConstraint: throwConstraint,
          landingSite: landingSite,
          index: index,
          numberOfJugglers: numberOfJugglers,
          period: period,
          prechator: prechator,
        );
      }).toList();

      final cartesianProduct =
          CartesianProductIterable<Throw>(bagsOfPossibleThrows)
              .map((throwSequence) => Pattern(
                    numberOfJugglers: numberOfJugglers,
                    throwSequence: throwSequence,
                  ))
              .where((pattern) => pattern.isValid(
                    minNumberOfPasses: minNumberOfPasses,
                    maxNumberOfPasses: maxNumberOfPasses,
                    numberOfObjects: numberOfObjects,
                    numberOfJugglers: numberOfJugglers,
                  ))
              .map((pattern) => pattern.normalize());
      setOfPatterns.addAll(cartesianProduct);
    }

    final listOfPatterns = setOfPatterns.toList()..sort();
    return listOfPatterns;
  }

  List<Throw> possibleThrows({
    required ThrowConstraint throwConstraint,
    required int index,
    required int landingSite,
    required int numberOfJugglers,
    required int period,
    required Fraction prechator,
  }) {
    final height = throwConstraint.height;
    final passingIndex = throwConstraint.passingIndex;
    // if (height != null && passingIndex != null) {
    //   return [Throw(height: height, passingIndex: passingIndex)];
    // }

    final isFullyDefinedThrow = height != null && passingIndex != null;

    final int negativeSelfHeight;
    if (landingSite == index) {
      negativeSelfHeight = -period;
    } else if (landingSite >= index) {
      negativeSelfHeight = landingSite - index - period;
    } else {
      negativeSelfHeight = landingSite - index;
    }

    var results = <Throw>[];
    var possibleHeight = negativeSelfHeight.toFraction();
    var possiblePassingIndex = 0;
    while (possibleHeight <= maxHeight.toFraction()) {
      final possibleThrow = Throw(
        height: possibleHeight.reduce(),
        passingIndex: possiblePassingIndex,
      );
      if ((isFullyDefinedThrow || possibleThrow.isValid()) &&
          possibleThrow.satisfiesConstraint(throwConstraint)) {
        results.add(possibleThrow);
      }
      possibleHeight += prechator;
      possiblePassingIndex = (possiblePassingIndex + 1) % numberOfJugglers;
    }
    return results;
  }
}
