part of 'search_results_cubit.dart';

abstract class SearchResultsState extends Equatable {
  const SearchResultsState();

  @override
  List<Object> get props => [];
}

class SearchResultsInitial extends SearchResultsState {}
