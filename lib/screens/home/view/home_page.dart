import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

import '../../../patterns_bloc/patterns_bloc.dart';
import '../../attributions/attributions.dart';
import '../home.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static const routeName = '';

  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatternsBloc, PatternsState>(
      listener: (context, state) {
        if (state is PatternsLoaded) {
          Navigator.push(
            context,
            SearchResultsPage.route(),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PrechacThis'),
          actions: <Widget>[
            IconButton(
              key: const Key('homePage_attributions_iconButton'),
              icon: const Icon(Icons.info_outline),
              onPressed: () => Navigator.pushNamed(
                context,
                AttributionsPage.routeName,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocProvider(
            create: (_) => ConstraintsFormBloc(
              patternsBloc: BlocProvider.of<PatternsBloc>(context),
            ),
            child: ConstraintsForm(),
          ),
        ),
      ),
    );
  }
}
