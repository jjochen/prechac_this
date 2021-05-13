import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_repository/pattern_repository.dart';
import '../search_results.dart';

class SearchResultsPage extends StatelessWidget {
  SearchResultsPage({
    Key? key,
    required this.searchParameters,
  }) : super(key: key);

  static const routeName = 'results';
  static String routeNameWithParameters(SearchParameters parameters) {
    return Uri(
      pathSegments: [routeName],
      queryParameters: parameters.toQueryParameters(),
    ).toString();
  }

  final SearchParameters searchParameters;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(),
      child: SearchResultsView(),
    );
  }
}

class SearchResultsView extends StatelessWidget {
  SearchResultsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: RepositoryProvider(
            create: (_) => PatternRepository(),
            child: BlocProvider(
              create: (_) => SearchBloc(),
              child: const Text('Test'),
            ),
          )),
    );
  }
}
