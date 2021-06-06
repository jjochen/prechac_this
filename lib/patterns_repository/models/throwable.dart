import 'package:equatable/equatable.dart';
import 'package:fraction/fraction.dart';

import '../../core/core.dart';

abstract class Throwable
    with Comparable<Throwable>, Compare<Throwable>, EquatableMixin {
  const Throwable();

  Fraction? get height;
  int? get passingIndex;

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
  List<Object?> get props => [height, passingIndex];

  @override
  String toString() {
    return toStringShowingPassingIndex(true);
  }

  String toStringShowingPassingIndex(bool showPassingIndex) {
    if (isPlaceholder) {
      return '_';
    }

    if (isSelf) {
      return heightToString();
    }

    if (showPassingIndex) {
      return '${heightToString()}p${passingIndexToString()}';
    }

    return '${heightToString()}p';
  }

  String heightToString() {
    final height = this.height;
    if (height == null) {
      return '_';
    }

    if (height.isWhole) {
      return height.toString();
    }

    final decimalPart = height.toDouble() % 1;
    if (decimalPart.toString().length < 5) {
      return height.toDouble().toString();
    }

    final mod = 10.0;
    final truncatedToOneDecimalDigit =
        (height.toDouble() * mod).truncateToDouble() / mod;
    return truncatedToOneDecimalDigit.toString();
  }

  String passingIndexToString() {
    final passingIndex = this.passingIndex;
    if (passingIndex == null) {
      return '_';
    }

    const map = {
      0: '',
      1: '\u2081',
      2: '\u2082',
      3: '\u2083',
      4: '\u2084',
      5: '\u2085',
      6: '\u2086',
      7: '\u2087',
      8: '\u2088',
      9: '\u2089',
    };

    return map[passingIndex] ?? passingIndex.toString();
  }

  @override
  int compareTo(Throwable other) {
    final heightComparator = _compareHeightTo(other);
    if (heightComparator != 0) {
      return heightComparator;
    }

    final passingIndexComparator = _comparePassingIndexTo(other);
    return passingIndexComparator;
  }

  int _compareHeightTo(Throwable other) {
    final thisHeight = height;
    final otherHeight = other.height;

    if (thisHeight == null && otherHeight == null) {
      return 0;
    }

    if (thisHeight == null) {
      return -1;
    }

    if (otherHeight == null) {
      return 1;
    }

    final heightComparator = thisHeight.compareTo(otherHeight);
    return heightComparator;
  }

  int _comparePassingIndexTo(Throwable other) {
    final thisPassingIndex = passingIndex;
    final otherPassingIndex = other.passingIndex;

    if (thisPassingIndex == null && otherPassingIndex == null) {
      return 0;
    }

    if (thisPassingIndex == null) {
      return -1;
    }

    if (otherPassingIndex == null) {
      return 1;
    }

    final passingIndexComparator =
        thisPassingIndex.compareTo(otherPassingIndex);
    return passingIndexComparator;
  }
}
