import 'package:equatable/equatable.dart';

import '../core/core.dart';

class SearchParameters extends Equatable {
  SearchParameters({
    required this.numberOfJugglers,
    required this.period,
    required this.numberOfObjects,
    required this.maxHeight,
    this.minNumberOfPasses = -1,
    this.maxNumberOfPasses = -1,
  });

  factory SearchParameters.fromQueryParameters(Map<String, String> map) {
    final numberOfJuggers = map.intForKey('number_of_jugglers', fallback: -1);
    final period = map.intForKey('period', fallback: -1);
    final numberOfObjects = map.intForKey('number_of_objects', fallback: -1);
    final maxHeight = map.intForKey('max_height', fallback: -1);
    final minNumberOfPasses =
        map.intForKey('min_number_of_passes', fallback: -1);
    final maxNumberOfPasses =
        map.intForKey('max_number_of_passes', fallback: -1);

    return SearchParameters(
      numberOfJugglers: numberOfJuggers,
      period: period,
      numberOfObjects: numberOfObjects,
      maxHeight: maxHeight,
      minNumberOfPasses: minNumberOfPasses,
      maxNumberOfPasses: maxNumberOfPasses,
    );
  }

  final int numberOfJugglers;
  final int period;
  final int numberOfObjects;
  final int maxHeight;
  final int minNumberOfPasses;
  final int maxNumberOfPasses;

  SearchParameters copyWith({
    int? numberOfJugglers,
    int? period,
    int? numberOfObjects,
    int? maxHeight,
    int? minNumberOfPasses,
    int? maxNumberOfPasses,
  }) {
    return SearchParameters(
      numberOfJugglers: numberOfJugglers ?? this.numberOfJugglers,
      period: period ?? this.period,
      numberOfObjects: numberOfObjects ?? this.numberOfObjects,
      maxHeight: maxHeight ?? this.maxHeight,
      minNumberOfPasses: minNumberOfPasses ?? this.minNumberOfPasses,
      maxNumberOfPasses: maxNumberOfPasses ?? this.maxNumberOfPasses,
    );
  }

  Map<String, String> toQueryParameters() {
    return {
      'number_of_jugglers': numberOfJugglers.toString(),
      'period': period.toString(),
      'number_of_objects': numberOfObjects.toString(),
      'max_height': maxHeight.toString(),
      'min_number_of_passes': minNumberOfPasses.toString(),
      'max_number_of_passes': maxNumberOfPasses.toString(),
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      numberOfJugglers,
      period,
      numberOfObjects,
      maxHeight,
      minNumberOfPasses,
      maxNumberOfPasses,
    ];
  }
}
