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

  Stream<List<Pattern>> patterns() {
    // * constraint pattern as input
    // * calculate missing landing sites
    // * permutate missing landing sites
    // * fill in minimal selfs
    // * prechac up/down to correct number of objects and passes
    //   (pass height might be lower then minimal self!)

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
