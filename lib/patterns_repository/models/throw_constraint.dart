import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';

import 'throwable.dart';

@immutable
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
        limitToPass: passingIndex != 0,
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
  List<Object?> get props => [height, passingIndex, limitToPass];

  @override
  final Fraction? height;
  @override
  final int? passingIndex;

  final bool limitToPass;

  @override
  bool get isPlaceholder => !limitToPass && super.isPlaceholder;

  @override
  bool get isPass => limitToPass || super.isPass;
}
