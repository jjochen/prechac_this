import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../patterns_bloc/patterns_bloc.dart';
import '../search_results.dart';

class SearchResultsPage extends StatelessWidget {
  SearchResultsPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SearchResultsPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatternsBloc, PatternsState>(
      builder: (context, state) {
        final patterns = state is PatternsLoaded ? state.patterns : [];
        return Scaffold(
          appBar: AppBar(
            title: const Text('Results'),
          ),
          body: ListView.builder(
            itemCount: patterns.length,
            itemBuilder: (context, index) {
              final pattern = patterns[index];
              return PatternItem(
                pattern: pattern,
                //   onTap: () => Navigator.pushNamed(context, route),
              );
            },
          ),
        );
      },
    );
  }
}
