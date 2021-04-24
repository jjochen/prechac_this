import 'package:fraction/fraction.dart';
import 'package:trotter/trotter.dart';

import '../models/models.dart';

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

  Stream<List<Pattern>> fillConstraint({required Pattern pattern}) {
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

  Iterable<List<int>> permutationsOfPossibleLandingSites(Pattern pattern) {
    final allSites = List<int>.generate(pattern.period, (int index) => index);
    final existingSites = _landingSites(pattern);
    final missingSites =
        allSites.where((element) => !existingSites.contains(element)).toList();
    final numberOfMissingSites = missingSites.length;
    final permutationsOfMissingSites =
        Permutations(numberOfMissingSites, missingSites);

    return permutationsOfMissingSites()
        .map((missing) => _fillMissingSites(existingSites, missing));
  }

  List<int> _fillMissingSites(List<int> existing, List<int> missing) {
    return existing.map((site) {
      if (site < 0) {
        final first = missing.first;
        missing.removeAt(0);
        return first;
      } else {
        return site;
      }
    }).toList();
  }

  List<int> _landingSites(Pattern pattern) {
    return pattern.mapIndexedThrows((index, indexedThrow) {
      return _landingSite(
        aThrow: indexedThrow,
        position: index,
        period: period,
      );
    }).toList();
  }

  int _landingSite({
    required Throw aThrow,
    required int position,
    required int period,
  }) {
    final height = aThrow.height;
    final passingIndex = aThrow.passingIndex;
    if (height == null || passingIndex == null) {
      return -1;
    }

    final wholeHeight =
        (height - (prechator * passingIndex.toFraction())).reduce();

    if (!wholeHeight.isWhole) {
      throw Exception('not a valid self height: $wholeHeight');
    }

    return (position + wholeHeight.numerator) % period;
  }
}
