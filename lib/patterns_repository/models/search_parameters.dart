import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:prechac_this/core/core.dart';

@immutable
class SearchParameters extends Equatable {
  const SearchParameters({
    required this.numberOfJugglers,
    required this.period,
    required this.numberOfObjects,
    required this.maxHeight,
    this.minNumberOfPasses = -1,
    this.maxNumberOfPasses = -1,
    this.contains = '',
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
    final contains = map.stringForKey('contains', fallback: '');

    return SearchParameters(
      numberOfJugglers: numberOfJuggers,
      period: period,
      numberOfObjects: numberOfObjects,
      maxHeight: maxHeight,
      minNumberOfPasses: minNumberOfPasses,
      maxNumberOfPasses: maxNumberOfPasses,
      contains: contains,
    );
  }

  final int numberOfJugglers;
  final int period;
  final int numberOfObjects;
  final int maxHeight;
  final int minNumberOfPasses;
  final int maxNumberOfPasses;
  final String contains;

  SearchParameters copyWith({
    int? numberOfJugglers,
    int? period,
    int? numberOfObjects,
    int? maxHeight,
    int? minNumberOfPasses,
    int? maxNumberOfPasses,
    String? contains,
  }) {
    return SearchParameters(
      numberOfJugglers: numberOfJugglers ?? this.numberOfJugglers,
      period: period ?? this.period,
      numberOfObjects: numberOfObjects ?? this.numberOfObjects,
      maxHeight: maxHeight ?? this.maxHeight,
      minNumberOfPasses: minNumberOfPasses ?? this.minNumberOfPasses,
      maxNumberOfPasses: maxNumberOfPasses ?? this.maxNumberOfPasses,
      contains: contains ?? this.contains,
    );
  }

  Map<String, String> toQueryParameters() {
    var queryParameters = <String, String>{}
      ..setNonNegativeIntForKey(numberOfJugglers, 'number_of_jugglers')
      ..setNonNegativeIntForKey(period, 'period')
      ..setNonNegativeIntForKey(numberOfObjects, 'number_of_objects')
      ..setNonNegativeIntForKey(maxHeight, 'max_height')
      ..setNonNegativeIntForKey(minNumberOfPasses, 'min_number_of_passes')
      ..setNonNegativeIntForKey(maxNumberOfPasses, 'max_number_of_passes')
      ..['contains'] = contains;
    return queryParameters;
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
      contains,
    ];
  }
}

extension _QueryParameters on Map<String, String> {
  void setNonNegativeIntForKey(int value, String key) {
    if (value >= 0) {
      this[key] = value.toString();
    }
  }
}
