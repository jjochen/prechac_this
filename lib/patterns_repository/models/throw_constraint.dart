import 'package:fraction/fraction.dart';
import 'package:prechac_this/patterns_repository/exceptions/pattern_repository_exception.dart';

import 'throwable.dart';

class ThrowConstraint extends Throwable {
  const ThrowConstraint({
    required this.height,
    required this.passingIndex,
    this.limitToPass = false,
  });

  factory ThrowConstraint.pass({
    required double? height,
    int? passingIndex,
  }) =>
      ThrowConstraint(
        height: height?.toFraction(),
        passingIndex: passingIndex,
        limitToPass: true,
      );

  factory ThrowConstraint.self({required int? height}) => ThrowConstraint(
        height: height?.toFraction(),
        passingIndex: 0,
      );

  factory ThrowConstraint.placeholder() => const ThrowConstraint(
        height: null,
        passingIndex: null,
      );

  @override
  final Fraction? height;
  @override
  final int? passingIndex;

  final bool limitToPass;

  @override
  bool get isPlaceholder => !limitToPass && super.isPlaceholder;

  @override
  bool get isPass => limitToPass || super.isPass;

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
