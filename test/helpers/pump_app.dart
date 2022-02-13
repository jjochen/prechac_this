import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/flow/app_flow.dart';

import 'helpers.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp({
    List<BlocProvider>? providers,
    FlowController<AppFlowState>? flowController,
    required Widget child,
  }) async {
    await pumpWidget(
      TestApp(
        providers: providers,
        flowController: flowController,
        child: child,
      ),
    );
  }
}
