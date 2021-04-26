import 'package:fraction/fraction.dart';

import '../models/models.dart';
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
  Stream<List<Pattern>> fillConstraints(
      {required PatternConstraints patternConstraints}) {
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

    return Stream.fromIterable([
      [
        Pattern([
          Throw.self(height: 4),
          Throw.pass(height: 2),
          Throw.self(height: 1),
          Throw.pass(height: 1),
        ])
      ]
    ]);
  }

  Fraction get prechator {
    return Fraction(period, numberOfJugglers);
  }

  List<Throw> possibleThrows({
    required ThrowConstraints throwConstraints,
    required int landingSite,
    required int index,
  }) {
    final height = throwConstraints.height;
    final passingIndex = throwConstraints.passingIndex;
    if (height != null && passingIndex != null) {
      return [Throw(height: height, passingIndex: passingIndex)];
    }

    final int negativeSelfHeight;
    if (landingSite <= index) {
      negativeSelfHeight = landingSite - index;
    } else {
      negativeSelfHeight = period - landingSite - index;
    }

    var results = <Throw>[];
    var possibleHeight = negativeSelfHeight.toFraction();
    var possiblePassingIndex = 0;
    while (possibleHeight <= maxHeight.toFraction()) {
      final possibleThrow = Throw(
        height: possibleHeight.reduce(),
        passingIndex: possiblePassingIndex,
      );
      if (possibleThrow.isValid() &&
          possibleThrow.satisfiesConstraints(throwConstraints)) {
        results.add(possibleThrow);
      }
      possibleHeight += prechator;
      possiblePassingIndex = (possiblePassingIndex + 1) % numberOfJugglers;
    }
    return results;
  }
}
