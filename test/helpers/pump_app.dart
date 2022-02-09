import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/l10n/l10n.dart';
import 'package:prechac_this/navigation/app_navigator.dart';
import 'package:prechac_this/navigation/cubit/navigation_cubit.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    Widget? widget,
    PatternsBloc? patternsBloc,
    NavigationCubit? navigationCubit,
  }) {
    final app = MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: widget ?? const AppNavigator(),
    );

    if (patternsBloc == null && navigationCubit == null) {
      return pumpWidget(app);
    }

    return pumpWidget(
      MultiBlocProvider(
        providers: [
          if (patternsBloc != null)
            BlocProvider<PatternsBloc>(create: (_) => patternsBloc),
          if (navigationCubit != null)
            BlocProvider<NavigationCubit>(create: (_) => navigationCubit),
        ],
        child: app,
      ),
    );
  }
}
