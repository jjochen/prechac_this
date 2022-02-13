import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

class FlowControlledWidget<T> extends StatelessWidget {
  const FlowControlledWidget({
    Key? key,
    this.flowController,
    required this.child,
  }) : super(key: key);

  final FlowController<T>? flowController;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final flowController = this.flowController;
    if (flowController == null) {
      return child;
    } else {
      return FlowBuilder<T>(
        onGeneratePages: (state, pages) => [
          MaterialPage<dynamic>(child: child),
        ],
        controller: flowController,
      );
    }
  }
}
