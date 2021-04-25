import 'package:fraction/fraction.dart';
import 'package:trotter/trotter.dart';

import '../models/pattern.dart';
import 'landing_sites.dart';
import 'prechac_throw.dart';

extension PrechacPattern on Pattern {
  Iterable<List<int>> permutationsOfPossibleLandingSites({
    required Fraction prechator,
  }) {
    final allSites = List<int>.generate(period, (int index) => index);
    final existingSites = landingSites(prechator: prechator);
    final missingSites =
        allSites.where((element) => !existingSites.contains(element)).toList();
    final numberOfMissingSites = missingSites.length;
    final permutationsOfMissingSites =
        Permutations(numberOfMissingSites, missingSites);

    return permutationsOfMissingSites().map(existingSites.fillMissingSites);
  }

  List<int> landingSites({
    required Fraction prechator,
  }) {
    return mapIndexedThrows((index, indexedThrow) {
      return indexedThrow.landingSite(
        position: index,
        period: period,
        prechator: prechator,
      );
    }).toList();
  }
}
