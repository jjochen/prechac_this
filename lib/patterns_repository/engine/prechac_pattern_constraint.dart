import 'package:trotter/trotter.dart';

import '../models/pattern_constraint.dart';
import 'landing_sites.dart';
import 'prechac_throw_constraint.dart';

extension PrechacPatternConstraint on PatternConstraint {
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
}
