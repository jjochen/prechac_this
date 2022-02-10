import 'package:equatable/equatable.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:prechac_this/screens/attributions/attributions.dart';
import 'package:prechac_this/screens/home/home.dart';
import 'package:prechac_this/screens/pattern_details/view/view.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

part 'app_flow_state.dart';

class AppFlow extends StatelessWidget {
  const AppFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<AppFlowState>(
      onGeneratePages: (state, pages) {
        final listOfPatterns = state.listOfPatterns;
        final currentPattern = state.currentPattern;
        return [
          const MaterialPage<dynamic>(child: HomePage()),
          if (listOfPatterns != null)
            MaterialPage<dynamic>(
              child: SearchResultsPage(patterns: listOfPatterns),
            ),
          if (currentPattern != null)
            MaterialPage<dynamic>(
              child: PatternDetailsPage(pattern: currentPattern),
            ),
          if (state.showAttributions)
            const MaterialPage<dynamic>(child: AttributionsPage()),
        ];
      },
    );
  }
}
