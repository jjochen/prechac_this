import 'package:flutter/material.dart';
import 'package:fraction/fraction.dart';

import 'throwable.dart';

@immutable
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

  static Throw? fromId(String id) {
    final components = id.split(_idSeparator);
    if (components.length != 3) {
      return null;
    }

    final int numerator;
    final int denominator;
    final int passingIndex;
    try {
      numerator = int.parse(components[0]);
      denominator = int.parse(components[1]);
      passingIndex = int.parse(components[2]);
    } catch (e) {
      return null;
    }

    return Throw(
      height: Fraction(numerator, denominator),
      passingIndex: passingIndex,
    );
  }

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
