import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prechac_this/app/flow/app_flow.dart';
import 'package:prechac_this/l10n/l10n.dart';

import 'widgets.dart';

class TestApp extends StatelessWidget {
  const TestApp({
    Key? key,
    this.providers,
    this.flowController,
    required this.child,
  }) : super(key: key);

  final List<BlocProvider>? providers;
  final FlowController<AppFlowState>? flowController;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: FlowControlledWidget(
        flowController: flowController,
        child: MultiBlocProviderOrWidget(
          providers: providers,
          child: child,
        ),
      ),
    );
  }
}
