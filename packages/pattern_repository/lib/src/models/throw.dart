import 'package:fraction/fraction.dart';

import 'throwable.dart';

class Throw extends Throwable {
  const Throw({
    required this.height,
    required this.passingIndex,
  });

  factory Throw.pass({
    required double height,
    int passingIndex = 1,
  }) =>
      Throw(
        height: height.toFraction(),
        passingIndex: passingIndex,
      );

  factory Throw.self({required int height}) => Throw(
        height: height.toFraction(),
        passingIndex: 0,
      );

  @override
  final Fraction height;
  @override
  final int passingIndex;
}
