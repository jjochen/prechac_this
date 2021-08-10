import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/engine/engine_throw.dart';
import 'package:prechac_this/patterns_repository/engine/engine_throw_constraint.dart';
import 'package:prechac_this/patterns_repository/engine/landing_sites.dart';
import 'package:prechac_this/patterns_repository/models/pattern_constraint.dart';
import 'package:prechac_this/patterns_repository/models/throw.dart';
import 'package:trotter/trotter.dart';

extension EnginePatternConstraint on PatternConstraint {
  Iterable<List<int>> permutationsOfPossibleLandingSites() {
    final allSites = List<int>.generate(period, (int index) => index);
    final existingSites = landingSites();
    final missingSites =
        allSites.where((element) => !existingSites.contains(element)).toList();
    final numberOfMissingSites = missingSites.length;
    final permutationsOfMissingSites =
        Permutations(numberOfMissingSites, missingSites);

    return permutationsOfMissingSites().map(existingSites.fillMissingSites);
  }

  List<int> landingSites() {
    return mapIndexedThrow((index, indexedThrowConstraint) {
      return indexedThrowConstraint.landingSite(
        position: index,
        period: period,
        prechator: prechator,
      );
    }).toList();
  }

  List<Throw> possibleThrows({
    required int index,
    required int landingSite,
  }) {
    final throwConstraint = throwAtIndex(index);
    final height = throwConstraint.height;
    final passingIndex = throwConstraint.passingIndex;

    final isFullyDefinedThrow = height != null && passingIndex != null;

    final int negativeSelfHeight;
    if (landingSite == index) {
      negativeSelfHeight = -period;
    } else if (landingSite >= index) {
      negativeSelfHeight = landingSite - index - period;
    } else {
      negativeSelfHeight = landingSite - index;
    }

    final results = <Throw>[];
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
