import 'package:equatable/equatable.dart';
import 'package:sprintf/sprintf.dart';

abstract class Throw extends Equatable {}

class SimpleThrow extends Throw {
  SimpleThrow({
    required this.height,
    this.passingIndex = 0,
  });

  SimpleThrow.placeholder() : this(height: null, passingIndex: null);

  final double? height;
  final int? passingIndex;

  @override
  List<Object?> get props => [height, passingIndex];

  @override
  String toString() {
    if (this == SimpleThrow.placeholder()) {
      return '_';
    }
    return _heightString() + _passingIndexString();
  }

  String _heightString() {
    final height = this.height;
    if (height == null) {
      return '_';
    }

    return sprintf('%.4g', [height]);
  }

  String _passingIndexString() {
    switch (passingIndex) {
      case null:
        return 'p_';
      case 0:
        return '';
      default:
        return 'p$passingIndex';
    }
  }
}

class Multiplex extends Throw {
  Multiplex(this.throws);

  final List<SimpleThrow> throws;

  @override
  List<Object?> get props => [throws];

  @override
  String toString() {
    final components = throws.map((e) => e.toString());
    return '[${components.join(', ')}]';
  }
}
