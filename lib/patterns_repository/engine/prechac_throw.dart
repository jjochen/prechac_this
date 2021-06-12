import 'package:fraction/fraction.dart';

import '../models/throw.dart';
import '../models/throw_constraint.dart';

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

  bool satisfiesConstraint(ThrowConstraint throwConstraint) {
    return passingIndexSatisfiesConstraint(throwConstraint) &&
        heightSatisfiesConstraint(throwConstraint);
  }

  bool heightSatisfiesConstraint(ThrowConstraint throwConstraint) {
    if (throwConstraint.height != null) {
      return height == throwConstraint.height;
    }

    return true;
  }

  bool passingIndexSatisfiesConstraint(ThrowConstraint throwConstraint) {
    if (throwConstraint.passingIndex != null) {
      return passingIndex == throwConstraint.passingIndex;
    }

    if (throwConstraint.limitToPass) {
      return passingIndex > 0;
    }

    return true;
  }
}
