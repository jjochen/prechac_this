import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prechac_this/l10n/l10n.dart';
import 'package:prechac_this/navigation/cubit/navigation_cubit.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({
    Key? key,
    required this.patterns,
  }) : super(key: key);

  final List<Pattern> patterns;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.searchResultAppBarTitle),
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
  }
}
