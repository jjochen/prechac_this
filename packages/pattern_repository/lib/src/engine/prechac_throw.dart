import 'package:fraction/fraction.dart';

import '../models/throw.dart';

extension PrechacThrow on Throw {
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

  bool satisfiesConstraints(Throw throwConstraints) {
    return isValid() &&
        passingIndexSatisfiesConstraint(throwConstraints.passingIndex) &&
        heightSatisfiesConstraint(throwConstraints.height);
  }

  bool isValid() {
    return isValidSelf() || isValidPass();
  }

  bool isValidSelf() {
    final height = this.height;
    final passingIndex = this.passingIndex;
    if (passingIndex == null || height == null) {
      return false;
    }

    if (passingIndex != 0) {
      return false;
    }

    if (height < 0.toFraction()) {
      return false;
    }

    if (height > 0.toFraction() && height < 1.toFraction()) {
      return false;
    }

    return true;
  }

  bool isValidPass() {
    final height = this.height;
    final passingIndex = this.passingIndex;
    if (passingIndex == null || height == null) {
      return false;
    }

    if (passingIndex <= 0) {
      return false;
    }

    if (height < 1.toFraction()) {
      return false;
    }

    return true;
  }

  bool heightSatisfiesConstraint(Fraction? heightConstraint) {
    final height = this.height;
    if (height == null || heightConstraint == null) {
      return true;
    }

    return height == heightConstraint;
  }

  bool passingIndexSatisfiesConstraint(int? passingIndexConstraint) {
    final passingIndex = this.passingIndex;
    if (passingIndex == null || passingIndexConstraint == null) {
      return true;
    }

    return passingIndex == passingIndexConstraint;
  }
}
