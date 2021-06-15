import 'package:fraction/fraction.dart';

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
}
