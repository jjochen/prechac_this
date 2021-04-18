import 'package:equatable/equatable.dart';
import 'package:sprintf/sprintf.dart';

abstract class Throw extends Equatable {}

class Self extends Throw {
  Self({
    required this.height,
  });

  final int? height;

  @override
  List<Object?> get props => [height];

  @override
  String toString() {
    final height = this.height;
    if (height == null) {
      return '_';
    }

    return height.toString();
  }
}

class Pass extends Throw {
  Pass({
    required this.height,
    required this.passingIndex,
  });

  final double? height;
  final int? passingIndex;

  @override
  List<Object?> get props => [height, passingIndex];

  @override
  String toString() {
    return '${heightToString()}p${passingIndexToString()}';
  }

  String heightToString() {
    final height = this.height;
    if (height == null) {
      return '_';
    }

    return sprintf('%.4g', [height]);
  }

  String passingIndexToString() {
    final passingIndex = this.passingIndex;
    if (passingIndex == null) {
      return '_';
    }

    return passingIndex.toString();
  }
}

// class Multiplex extends Throw {
//   Multiplex(this.throws);

//   final List<Throw> throws;

//   @override
//   List<Object?> get props => [throws];

//   @override
//   String toString() {
//     final components = throws.map((simpleThrow) => simpleThrow.toString());
//     return '[${components.join(', ')}]';
//   }
// }

class Placeholder extends Throw {
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return '_';
  }
}
