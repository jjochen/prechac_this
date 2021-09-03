import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prechac_this/navigation/cubit/navigation_cubit.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatternsBloc, PatternsState>(
      builder: (context, state) {
        final patterns = state is PatternsLoaded ? state.patterns : <Pattern>[];
        return Scaffold(
          appBar: AppBar(
            title: const Text('Results'),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: patterns.length,
            itemBuilder: (context, index) {
              final pattern = patterns[index];
              return PatternItem(
                pattern: pattern,
                onTap: () => context
                    .read<NavigationCubit>()
                    .navigateToPatternDetailView(pattern),
              );
            },
          ),
        );
      },
    );
  }
}
