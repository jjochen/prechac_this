import 'package:fraction/fraction.dart';

import 'throwable.dart';

class ThrowConstraint extends Throwable {
  const ThrowConstraint({
    required this.height,
    required this.passingIndex,
    this.limmitToPass = false,
  });

  factory ThrowConstraint.pass({
    required double? height,
    int? passingIndex,
  }) =>
      ThrowConstraint(
        height: height?.toFraction(),
        passingIndex: passingIndex,
        limmitToPass: true,
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

  // TODO add optional function `isValid...` used when height/passingIndex is null

  final bool limmitToPass;

  @override
  bool get isPlaceholder => !limmitToPass && super.isPlaceholder;

  @override
  bool get isPass => limmitToPass || super.isPass;
}
