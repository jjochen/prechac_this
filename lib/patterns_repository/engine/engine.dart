import 'package:dartx/dartx.dart';
import 'package:prechac_this/core/core.dart';
import 'package:prechac_this/patterns_repository/engine/engine_pattern.dart';
import 'package:prechac_this/patterns_repository/engine/engine_pattern_constraint.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

class Engine {
  const Engine();

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

    final setOfPatterns = <Pattern>{};

    final permutations = patternConstraint.permutationsOfPossibleLandingSites();
    for (final landingSites in permutations) {
      final bagsOfPossibleThrows = patternConstraint.mapIndexed((index, _) {
        final landingSite = landingSites[index];
        return patternConstraint.possibleThrows(
          index: index,
          landingSite: landingSite,
        );
      }).toList();

      final cartesianProduct = CartesianProductIterable<Throw>(
        bagsOfPossibleThrows,
      )
          .map(
            (throwSequence) => Pattern(
              numberOfJugglers: patternConstraint.numberOfJugglers,
              throwSequence: throwSequence,
            ),
          )
          .where((pattern) => pattern.satisfiesConstraint(patternConstraint))
          .map((pattern) => pattern.normalize());
      setOfPatterns.addAll(cartesianProduct);
    }

    final listOfPatterns = setOfPatterns.toList()..sort();
    if (listOfPatterns.isEmpty) {
      throw const NoPatternsFoundException();
    }

    return listOfPatterns;
  }
}
