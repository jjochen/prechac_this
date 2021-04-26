import 'package:equatable/equatable.dart';
import 'package:fraction/fraction.dart';
import 'package:sprintf/sprintf.dart';

class ThrowConstraint extends Equatable {
  ThrowConstraint({
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

  factory ThrowConstraint.placeholder() => ThrowConstraint(
        height: null,
        passingIndex: null,
      );

  final Fraction? height;
  final int? passingIndex;

  @override
  List<Object?> get props => [height, passingIndex];

  bool get isSelf {
    return passingIndex != null && passingIndex == 0;
  }

  bool get isPass {
    return passingIndex != null && passingIndex != 0;
  }

  bool get isPlaceholder {
    return passingIndex == null && height == null;
  }

  @override
  String toString() {
    if (isPlaceholder) {
      return '_';
    }

    if (isSelf) {
      return heightToString();
    }

    return '${heightToString()}p${passingIndexToString()}';
  }

  String heightToString() {
    final height = this.height;
    if (height == null) {
      return '_';
    }

    return sprintf('%.4g', [height.toDouble()]);
  }

  String passingIndexToString() {
    final passingIndex = this.passingIndex;
    if (passingIndex == null) {
      return '_';
    }

    return passingIndex.toString();
  }
}
