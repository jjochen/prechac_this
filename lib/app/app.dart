import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prechac_this/app/theme.dart';
import 'package:prechac_this/core/computer.dart';
import 'package:prechac_this/l10n/l10n.dart';
import 'package:prechac_this/navigation/navigation.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PatternsBloc>(
          create: (context) => PatternsBloc(
            patternsRepository: PatternsRepository(computer: Computer()),
          ),
        ),
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(
            patternsBloc: context.read<PatternsBloc>(),
          ),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: const AppNavigator(),
    );
  }
}
