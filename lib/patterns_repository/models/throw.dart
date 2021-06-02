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

  static Throw? fromId(String id) {
    final components = id.split(_idSeparator);
    if (components.length != 3) {
      return null;
    }

    final numerator = int.parse(components[0]);
    final denominator = int.parse(components[1]);
    final passingIndex = int.parse(components[2]);

    return Throw(
      height: Fraction(numerator, denominator),
      passingIndex: passingIndex,
    );
  }

  @override
  final Fraction height;
  @override
  final int passingIndex;

  String get id {
    final reducedHeight = height.reduce();
    final components = [
      reducedHeight.numerator,
      reducedHeight.denominator,
      passingIndex,
    ];
    return components.map((c) => c.toString()).join(_idSeparator);
  }

  static const _idSeparator = '-';
}
