part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchPatterns extends SearchEvent {
  SearchPatterns(this.searchParameters);

  final SearchParameters searchParameters;

  @override
  List<Object> get props => [searchParameters];
}

class FoundPatterns extends SearchEvent {
  FoundPatterns(this.patterns);

  final List<Pattern> patterns;

  @override
  List<Object> get props => [patterns];
}
