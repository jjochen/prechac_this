import 'dart:async';

import 'package:async/async.dart';
import 'package:fraction/fraction.dart';

import '../core/core.dart';
import '../models/models.dart';
import 'prechac_pattern.dart';
import 'prechac_pattern_constraint.dart';
import 'prechac_throw.dart';

class Engine {
  Engine({
    required this.numberOfJugglers,
    required this.period,
    required this.numberOfObjects,
    required this.maxHeight,
    int? minNumberOfPasses,
    int? maxNumberOfPasses,
  })  : minNumberOfPasses = minNumberOfPasses ?? 0,
        maxNumberOfPasses = maxNumberOfPasses ?? period;

  final int numberOfJugglers;
  final int period;
  final int numberOfObjects;
  final int maxHeight;
  final int minNumberOfPasses;
  final int maxNumberOfPasses;

// TODO: rename
  Stream<Pattern> fillConstraint(
      {required PatternConstraint patternConstraint}) {
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

    var streams = <Stream<Pattern>>[];
    final permutations = patternConstraint.permutationsOfPossibleLandingSites(
        prechator: prechator);
    for (final landingSites in permutations) {
      final bagsOfPossibleThrows =
          patternConstraint.mapIndexedThrow((index, throwConstraint) {
        final landingSite = landingSites[index];
        return possibleThrows(
          throwConstraint: throwConstraint,
          landingSite: landingSite,
          index: index,
        );
      }).toList();

      final cartesianProduct =
          CartesianProductIterable<Throw>(bagsOfPossibleThrows)
              .map((throwSequence) => Pattern(throwSequence))
              .where((pattern) => pattern.isValid(
                    minNumberOfPasses: minNumberOfPasses,
                    maxNumberOfPasses: maxNumberOfPasses,
                    numberOfObjects: numberOfObjects,
                    numberOfJugglers: numberOfJugglers,
                  ))
              .map((pattern) => pattern.normalize());
      streams.add(Stream.fromIterable(cartesianProduct));
    }

    return StreamGroup.merge(streams);
  }

  Fraction get prechator {
    return Fraction(period, numberOfJugglers);
  }

  List<Throw> possibleThrows({
    required ThrowConstraint throwConstraint,
    required int landingSite,
    required int index,
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
