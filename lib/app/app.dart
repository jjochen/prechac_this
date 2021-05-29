import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../l10n/l10n.dart';
import '../patterns_bloc/patterns_bloc.dart';
import '../patterns_repository/patterns_repository.dart';
import '../screens/home/home.dart';
import 'app_router.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PatternsBloc(
        patternsRepository: PatternsRepository(),
      ),
      child: MaterialApp(
        theme: theme,
        initialRoute: HomePage.routeName,
        onGenerateRoute: AppRouter.generateRoute,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
