// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
      patternsBloc = MockPatternsBloc();
    });

    testWidgets('renders HomePage', (tester) async {
      when(() => patternsBloc.state).thenReturn(
        PatternsInitial(),
      );
      await tester.pumpApp(
        providers: [BlocProvider(create: (_) => patternsBloc)],
        child: AppView(),
      );
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
