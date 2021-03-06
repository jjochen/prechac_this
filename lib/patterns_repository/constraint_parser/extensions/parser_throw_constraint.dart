import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

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
      final message = "$this and $other can't be merged.";
      throw ConstraintsInvalidException(message);
    }

    final mergedLimitToPass = limitToPass || other.limitToPass;

    if (mergedLimitToPass && mergedPassingIndex == 0) {
      final message = "$this and $other can't be merged.";
      throw ConstraintsInvalidException(message);
    }

    final Fraction? mergedHeight;
    if (other.height == height) {
      mergedHeight = height;
    } else if (other.height == null) {
      mergedHeight = height;
    } else if (height == null) {
      mergedHeight = other.height;
    } else {
      final message = "$this and $other can't be merged.";
      throw ConstraintsInvalidException(message);
    }

    return ThrowConstraint(
      height: mergedHeight,
      passingIndex: mergedPassingIndex,
      limitToPass: mergedLimitToPass,
    );
  }
}
