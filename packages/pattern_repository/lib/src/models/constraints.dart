import 'package:equatable/equatable.dart';

import 'pattern.dart';

class Constraints extends Equatable {
  Constraints({
    required this.numberOfJugglers,
    required this.numberOfObjects,
    required this.maxHeight,
    required this.minNumberOfPasses,
    required this.maxNumberOfPasses,
    required this.pattern,
  });

  final int numberOfJugglers;
  final int numberOfObjects;
  final int maxHeight;
  final int minNumberOfPasses;
  final int maxNumberOfPasses;
  final Pattern pattern;

  @override
  List<Object?> get props => [
        numberOfJugglers,
        numberOfObjects,
        maxHeight,
        minNumberOfPasses,
        maxNumberOfPasses,
        pattern,
      ];

  @override
  bool? get stringify => true;
}
