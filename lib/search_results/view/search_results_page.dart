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

  final SearchParameters searchParameters;

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
              create: (_) => SearchResultsCubit(),
              child: Text(searchParameters.toString()),
            ),
          )),
    );
  }
}
