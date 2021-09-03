import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prechac_this/navigation/navigation.dart';
import 'package:prechac_this/screens/attributions/attributions.dart';
import 'package:prechac_this/screens/home/home.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      final listOfPatterns = state.listOfPatterns;
      // final currentPattern = state.currentPattern;
      return Navigator(
        pages: [
          const MaterialPage<dynamic>(child: HomePage()),
          if (listOfPatterns != null)
            MaterialPage<dynamic>(
              child: SearchResultsPage(patterns: listOfPatterns),
            ),
          // if (currentPattern != null)
          //   MaterialPage<dynamic>(
          //     child: PatternDetailsPage(pattern: currentPattern),
          //   ),
          if (state.showAttributions)
            const MaterialPage<dynamic>(child: AttributionsPage()),
        ],
        onPopPage: (Route<dynamic> route, dynamic result) {
          context.read<NavigationCubit>().pop();
          return route.didPop(result);
        },
      );
    });
  }
}
