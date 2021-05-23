import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/app_router.dart';
import 'package:prechac_this/l10n/l10n.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp({Widget? widget, String? route}) {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: widget,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: route,
      ),
    );
  }
}
