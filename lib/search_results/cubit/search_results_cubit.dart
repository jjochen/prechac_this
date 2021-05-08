import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_results_state.dart';

class SearchResultsCubit extends Cubit<SearchResultsState> {
  SearchResultsCubit() : super(SearchResultsInitial());
}
