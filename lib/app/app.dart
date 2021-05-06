import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../home/home.dart';
import '../l10n/l10n.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: HomePage(),
    );
  }
}
