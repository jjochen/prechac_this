import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/app_router.dart';
import 'package:prechac_this/l10n/l10n.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    Widget? widget,
    String? route,
    PatternsBloc? patternsBloc,
  }) {
    final app = _app(widget: widget, route: route);
    final appWidget = patternsBloc == null
        ? app
        : BlocProvider(
            create: (_) => patternsBloc,
            child: app,
          );

    return pumpWidget(appWidget);
  }
}

MaterialApp _app({Widget? widget, String? route}) {
  return MaterialApp(
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: widget,
    onGenerateRoute: AppRouter.generateRoute,
    initialRoute: route,
  );
}
