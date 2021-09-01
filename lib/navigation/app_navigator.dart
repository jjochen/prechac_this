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
      return Navigator(
        pages: [
          const MaterialPage<dynamic>(child: HomePage()),
          if (state.listOfPatterns != null)
            const MaterialPage<dynamic>(child: SearchResultsPage()),
          // if (state.currentPattern != null)
          //   const MaterialPage<dynamic>(child: PatternDetailsPage()),
          if (state.showAttributions)
            const MaterialPage<dynamic>(child: AttributionsPage()),
        ],
        onPopPage: (Route<dynamic> route, dynamic result) {
          BlocProvider.of<NavigationCubit>(context).pop();
          return route.didPop(result);
        },
      );
    });
  }
}
