import 'package:equatable/equatable.dart';

class Constraints extends Equatable {
  const Constraints({
    required this.numberOfJugglers,
    required this.period,
    required this.numberOfObjects,
    required this.maxHeight,
    this.minNumberOfPasses = 0,
    int? maxNumberOfPasses,
    this.contains,
  }) : maxNumberOfPasses = maxNumberOfPasses ?? period;

  final int numberOfJugglers;
  final int period;
  final int numberOfObjects;
  final int maxHeight;
  final int minNumberOfPasses;
  final int maxNumberOfPasses;
  final String? contains;

  @override
  List<Object?> get props => [
        numberOfJugglers,
        period,
        numberOfObjects,
        maxHeight,
        minNumberOfPasses,
        maxNumberOfPasses,
        contains,
      ];
}
