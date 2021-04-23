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
          Throw(height: 2, passingIndex: 1),
          Throw.self(height: 1),
          Throw(height: 1, passingIndex: 1),
        ])
      ]
    ]);
  }

// TODO: use rational
  double prechator() {
    return period / numberOfJugglers;
  }

  List<int> landingSites(Pattern pattern) {
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
    double? height;

    if (aThrow.isSelf) {
      height = aThrow.height;
    }

    if (aThrow.isPass) {
      height = _equivalentSelf(aThrow)?.height;
    }

    return _calculateLandingSite(
      height: height?.toInt(),
      position: position,
      period: period,
    );
  }

  int _calculateLandingSite({
    required int? height,
    required int position,
    required int period,
  }) {
    if (height == null) {
      return -1;
    }

    return (position + height) % period;
  }

  Throw? _equivalentSelf(Throw aThrow) {
    final passingIndex = aThrow.passingIndex;
    final passHeight = aThrow.height;

    if (passHeight == null || passingIndex == null) {
      return null;
    }

    final prechator = this.prechator();
    final selfHeight = (passHeight - (prechator * passingIndex)).round();
    return Throw.self(height: selfHeight);
  }

  List<int> missingLandingSites(Pattern pattern) {
    var sites = List<int>.generate(pattern.period, (int index) => index);
    final existingSites = landingSites(pattern);
    for (final site in existingSites) {
      sites.remove(site);
    }
    return sites;
  }
}
