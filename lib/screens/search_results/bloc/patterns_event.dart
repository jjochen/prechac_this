part of 'patterns_bloc.dart';

abstract class PatternsEvent extends Equatable {
  const PatternsEvent();

  @override
  List<Object> get props => [];
}

class LoadPatterns extends PatternsEvent {
  const LoadPatterns(this.searchParameters);

  final SearchParameters searchParameters;

  @override
  List<Object> get props => [searchParameters];
}

class PatternsUpdated extends PatternsEvent {
  const PatternsUpdated(this.patterns);

  final List<Pattern> patterns;

  @override
  List<Object> get props => [patterns];
}
