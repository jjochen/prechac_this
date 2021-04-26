import 'package:equatable/equatable.dart';
import 'package:fraction/fraction.dart';
import 'package:sprintf/sprintf.dart';

class Throw extends Equatable {
  Throw({
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

  final Fraction height;
  final int passingIndex;

  @override
  List<Object?> get props => [height, passingIndex];

  bool get isSelf {
    return passingIndex == 0;
  }

  bool get isPass {
    return passingIndex != 0;
  }

  @override
  String toString() {
    if (isSelf) {
      return heightToString();
    }

    return '${heightToString()}p${passingIndexToString()}';
  }

  String heightToString() {
    return sprintf('%.4g', [height.toDouble()]);
  }

  String passingIndexToString() {
    return passingIndex.toString();
  }
}
