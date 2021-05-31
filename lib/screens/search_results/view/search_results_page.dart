import 'package:flutter/material.dart';

import '../../../patterns_repository/patterns_repository.dart';
import '../search_results.dart';

class SearchResultsPage extends StatelessWidget {
  SearchResultsPage({
    Key? key,
    required this.patterns,
  }) : super(key: key);

  final List<Pattern> patterns;

  @override
  Widget build(BuildContext context) {
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
  }
}
