import 'package:fraction/fraction.dart';

import 'throwable.dart';

class ThrowConstraint extends Throwable {
  const ThrowConstraint({
    required this.height,
    required this.passingIndex,
  });

  factory ThrowConstraint.pass({
    required double? height,
    int? passingIndex = 1,
  }) =>
      ThrowConstraint(
        height: height?.toFraction(),
        passingIndex: passingIndex,
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
}