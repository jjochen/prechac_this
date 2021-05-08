import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prechac_this/attributions/attributions.dart';
import 'package:prechac_this/home/home.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static const String routeName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PrechacThis'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_attributions_iconButton'),
            icon: const Icon(Icons.info_outline),
            onPressed: () =>
                Navigator.pushNamed(context, AttributionsPage.routeName),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider(
          create: (_) => HomeCubit(),
          child: ConstraintsForm(),
        ),
      ),
    );
  }
}
