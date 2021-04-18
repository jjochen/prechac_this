import 'dart:async';

import 'models/models.dart';

class PatternRepository {
  PatternRepository({
    required this.numberOfJugglers,
    required this.numberOfObjects,
    required this.maxHeight,
    required this.minNumberOfPasses,
    required this.maxNumberOfPasses,
    required this.pattern,
  });

  final int numberOfJugglers;
  final int numberOfObjects;
  final int maxHeight;
  final int minNumberOfPasses;
  final int maxNumberOfPasses;
  final Pattern pattern;

  Stream<List<Pattern>> patterns() {
    return Stream.fromIterable([
      [
        Pattern([
          Self(height: 4),
          Pass(height: 2, passingIndex: 1),
          Self(height: 1),
          Pass(height: 1, passingIndex: 1),
        ])
      ]
    ]);
  }

// TODO: use rational
  double prechator() {
    return pattern.period / numberOfJugglers;
  }

  List<int> landingSites() {
    final period = pattern.period;
    return pattern.sequence.asMap().entries.map((entry) {
      return _landingSite(
        aThrow: entry.value,
        position: entry.key,
        period: period,
      );
    }).toList();
  }

  int _landingSite({
    required Throw aThrow,
    required int position,
    required int period,
  }) {
    int? height;

    if (aThrow is Self) {
      height = aThrow.height;
    }

    if (aThrow is Pass) {
      height = _equivalentSelfHeight(aThrow)?.height;
    }

    return _calculateLandingSite(
      height: height,
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

  Self? _equivalentSelfHeight(Pass pass) {
    final passingIndex = pass.passingIndex;
    final passHeight = pass.height;

    if (passHeight == null || passingIndex == null) {
      return null;
    }

    final prechator = this.prechator();
    final selfHeight = (passHeight - (prechator * passingIndex)).round();
    return Self(height: selfHeight);
  }
}
