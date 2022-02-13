import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBlocProviderOrWidget extends StatelessWidget {
  const MultiBlocProviderOrWidget({
    Key? key,
    this.providers,
    required this.child,
  }) : super(key: key);

  final List<BlocProvider>? providers;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final providers = this.providers;
    if (providers == null || providers.isEmpty) {
      return child;
    } else {
      return MultiBlocProvider(
        providers: providers,
        child: child,
      );
    }
  }
}
