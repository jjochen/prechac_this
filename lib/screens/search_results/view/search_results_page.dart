import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/pattern_repository/pattern_repository.dart';
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
      create: (_) => PatternsBloc(
        patternRepository: PatternRepository(),
      )..add(LoadPatterns(searchParameters)),
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
        body:
            BlocBuilder<PatternsBloc, PatternsState>(builder: (context, state) {
          if (state is PatternsLoading) {
            return const Text('Loading ...');
          } else if (state is PatternsLoaded) {
            final patterns = state.patterns;
            return Text(patterns.map((e) => e.toString()).join('\n'));
          } else {
            return Container();
          }
        }));
  }
}
