import 'dart:convert';

import 'package:equatable/equatable.dart';

class SearchParameters extends Equatable {
  SearchParameters({
    required this.numberOfJugglers,
    required this.period,
    required this.numberOfObjects,
    required this.maxHeight,
    this.minNumberOfPasses,
    this.maxNumberOfPasses,
  });

  factory SearchParameters.fromMap(Map<String, dynamic?> map) {
    return SearchParameters(
      numberOfJugglers: map['number_of_jugglers'],
      period: map['period'],
      numberOfObjects: map['number_of_objects'],
      maxHeight: map['max_height'],
      minNumberOfPasses: map['min_number_of_passes'],
      maxNumberOfPasses: map['max_number_of_passes'],
    );
  }

  factory SearchParameters.fromJson(String source) =>
      SearchParameters.fromMap(json.decode(source));

  final int numberOfJugglers;
  final int period;
  final int numberOfObjects;
  final int maxHeight;
  final int? minNumberOfPasses;
  final int? maxNumberOfPasses;

  SearchParameters copyWith({
    int? numberOfJugglers,
    int? period,
    int? numberOfObjects,
    int? maxHeight,
    int? minNumberOfPasses = -1,
    int? maxNumberOfPasses = -1,
  }) {
    final minNumberOfPassesNotSet = minNumberOfPasses == -1;
    final maxNumberOfPassesNotSet = maxNumberOfPasses == -1;

    return SearchParameters(
      numberOfJugglers: numberOfJugglers ?? this.numberOfJugglers,
      period: period ?? this.period,
      numberOfObjects: numberOfObjects ?? this.numberOfObjects,
      maxHeight: maxHeight ?? this.maxHeight,
      minNumberOfPasses:
          minNumberOfPassesNotSet ? this.minNumberOfPasses : minNumberOfPasses,
      maxNumberOfPasses:
          maxNumberOfPassesNotSet ? this.maxNumberOfPasses : maxNumberOfPasses,
    );
  }

  Map<String, dynamic?> toMap() {
    return {
      'number_of_jugglers': numberOfJugglers,
      'period': period,
      'number_of_objects': numberOfObjects,
      'max_height': maxHeight,
      'min_number_of_passes': minNumberOfPasses,
      'max_number_of_passes': maxNumberOfPasses,
    };
  }

  String toJson() => json.encode(toMap());

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
