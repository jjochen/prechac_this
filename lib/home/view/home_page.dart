import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prechac_this/app/flow/app_flow.dart';
import 'package:prechac_this/core/computer.dart';
import 'package:prechac_this/home/home.dart';
import 'package:prechac_this/l10n/l10n.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeAppBarTitle),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_attributions_iconButton'),
            icon: const Icon(Icons.info_outline),
            onPressed: () => context
                .flow<AppFlowState>()
                .update((state) => state.copyWith(showAttributions: true)),
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) => ConstraintsFormBloc(
          patternsRepository: PatternsRepository(computer: Computer()),
        ),
        child: const ConstraintsForm(),
      ),
    );
  }
}
