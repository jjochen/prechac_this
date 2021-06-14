import 'package:fraction/fraction.dart';

import '../models/throw_constraint.dart';

extension EngineThrowConstraint on ThrowConstraint {
  int landingSite({
    required int position,
    required int period,
    required Fraction prechator,
  }) {
    final height = this.height;
    final passingIndex = this.passingIndex;
    if (height == null || passingIndex == null) {
      return -1;
    }

    final closestWholeHeight =
        (height - (prechator * passingIndex.toFraction())).toDouble().round();

    return (position + closestWholeHeight) % period;
  }
}
