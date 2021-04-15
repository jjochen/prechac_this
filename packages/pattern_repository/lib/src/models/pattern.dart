import 'package:equatable/equatable.dart';

import 'throw.dart';

class Pattern extends Equatable {
  const Pattern(this.sequence);

  final List<Throw> sequence;

  @override
  List<Object?> get props => [sequence];

  @override
  bool? get stringify => true;
}
