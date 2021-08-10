import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/models/throw.dart';
import 'package:prechac_this/patterns_repository/models/throw_constraint.dart';

extension EngineThrow on Throw {
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
    final constraintHeight = throwConstraint.height;
    if (constraintHeight != null) {
      const minDistance = 0.1;
      final distance = (height.toDouble() - constraintHeight.toDouble()).abs();
      return distance < minDistance;
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
