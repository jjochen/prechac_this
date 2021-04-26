import 'package:fraction/fraction.dart';

import '../models/throw.dart';
import '../models/throw_constraints.dart';

extension PrechacThrow on Throw {
  bool isValid() {
    return isValidSelf() || isValidPass();
  }

  bool isValidSelf() {
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
    if (passingIndex <= 0) {
      return false;
    }

    if (height < 1.toFraction()) {
      return false;
    }

    return true;
  }

  bool satisfiesConstraints(ThrowConstraints throwConstraints) {
    return passingIndexSatisfiesConstraint(throwConstraints.passingIndex) &&
        heightSatisfiesConstraint(throwConstraints.height);
  }

  bool heightSatisfiesConstraint(Fraction? heightConstraint) {
    if (heightConstraint == null) {
      return true;
    }

    return height == heightConstraint;
  }

  bool passingIndexSatisfiesConstraint(int? passingIndexConstraint) {
    if (passingIndexConstraint == null) {
      return true;
    }

    return passingIndex == passingIndexConstraint;
  }
}
