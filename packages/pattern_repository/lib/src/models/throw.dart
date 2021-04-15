import 'package:equatable/equatable.dart';

abstract class Throw extends Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

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
}

class Multiplex extends Throw {
  Multiplex(this.throws);

  final List<SimpleThrow> throws;

  @override
  List<Object?> get props => [throws];
}
