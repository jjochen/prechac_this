import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/flow/app_flow.dart';
import 'package:prechac_this/l10n/l10n.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    List<BlocProvider>? providers,
    FlowController<AppFlowState>? flowController,
    required Widget child,
  }) {
    final app = flowControlledApp<AppFlowState>(
      flowController: flowController,
      home: child,
    );

    final appWithProviders = wrapWithProviders(
      app,
      providers: providers,
    );

    return pumpWidget(appWithProviders);
  }

  Widget wrapWithProviders(Widget widget, {List<BlocProvider>? providers}) {
    if (providers == null || providers.isEmpty) {
      return widget;
    } else {
      return MultiBlocProvider(
        providers: providers,
        child: widget,
      );
    }
  }

  MaterialApp flowControlledApp<T>({
    FlowController<T>? flowController,
    required Widget home,
  }) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: flowControllWidget<T>(home, flowController: flowController),
    );
  }

  Widget flowControllWidget<T>(
    Widget widget, {
    FlowController<T>? flowController,
  }) {
    if (flowController == null) {
      return widget;
    }

    return FlowBuilder<T>(
      onGeneratePages: (state, pages) => [
        MaterialPage<dynamic>(child: widget),
      ],
      controller: flowController,
    );
  }
}
