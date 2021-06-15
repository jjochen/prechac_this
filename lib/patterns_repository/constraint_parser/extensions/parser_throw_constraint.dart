import 'package:fraction/fraction.dart';

import '../../patterns_repository.dart';

extension ParserThrowConstraint on ThrowConstraint {
  ThrowConstraint merge(ThrowConstraint other) {
    final int? mergedPassingIndex;
    if (other.passingIndex == passingIndex) {
      mergedPassingIndex = passingIndex;
    } else if (other.passingIndex == null) {
      mergedPassingIndex = passingIndex;
    } else if (passingIndex == null) {
      mergedPassingIndex = other.passingIndex;
    } else {
      throw (const ConstraintMergeConflictException());
    }

    final mergedLimitToPass = limitToPass || other.limitToPass;

    if (mergedLimitToPass && mergedPassingIndex == 0) {
      throw (const ConstraintMergeConflictException());
    }

    final Fraction? mergedHeight;
    if (other.height == height) {
      mergedHeight = height;
    } else if (other.height == null) {
      mergedHeight = height;
    } else if (height == null) {
      mergedHeight = other.height;
    } else {
      throw (const ConstraintMergeConflictException());
    }

    return ThrowConstraint(
      height: mergedHeight,
      passingIndex: mergedPassingIndex,
      limitToPass: mergedLimitToPass,
    );
  }
}
