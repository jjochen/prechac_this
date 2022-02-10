import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/flow/app_flow.dart';
import 'package:prechac_this/l10n/l10n.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    Widget? widget,
    PatternsBloc? patternsBloc,
    AppFlow? appFlow,
  }) {
    final app = MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: widget ?? const AppFlow(),
    );

    if (patternsBloc == null) {
      return pumpWidget(app);
    }

    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<PatternsBloc>(create: (_) => patternsBloc),
        ],
        child: app,
      ),
    );
  }
}
