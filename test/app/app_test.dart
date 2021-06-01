// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/app.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/screens/home/home.dart';

import '../helpers/helpers.dart';

void main() {
  group('App', () {
    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    late PatternsBloc patternsBloc;

    setUp(() {
      registerFallbackValue(FakePatternsEvent());
      registerFallbackValue(PatternsInitial());
      patternsBloc = MockPatternsBloc();
    });

    testWidgets('renders HomePage', (tester) async {
      when(() => patternsBloc.state).thenReturn(
        PatternsInitial(),
      );
      await tester.pumpApp(
        patternsBloc: patternsBloc,
        widget: AppView(),
      );
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
