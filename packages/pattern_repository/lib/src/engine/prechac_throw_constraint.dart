import 'package:fraction/fraction.dart';

import '../models/throw_constraint.dart';

extension PrechacThrowConstraint on ThrowConstraint {
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

    final wholeHeight =
        (height - (prechator * passingIndex.toFraction())).reduce();

    if (!wholeHeight.isWhole) {
      throw Exception('not a valid self height: $wholeHeight');
    }

    return (position + wholeHeight.numerator) % period;
  }
}
