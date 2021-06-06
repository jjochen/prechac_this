// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/screens/attributions/attributions.dart';
import 'package:prechac_this/screens/home/home.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

import '../../../helpers/helpers.dart';

void main() {
  const attributionsButtonKey = Key('homePage_attributions_iconButton');

  late PatternsBloc patternsBloc;

  setUp(() {
    registerFallbackValue(FakePatternsEvent());
    registerFallbackValue(PatternsInitial());
    patternsBloc = MockPatternsBloc();
  });

  group('HomePage', () {
    testWidgets('renders a ConstraintsForm', (tester) async {
      when(() => patternsBloc.state).thenReturn(
        PatternsInitial(),
      );
      await tester.pumpApp(
        patternsBloc: patternsBloc,
        widget: HomePage(),
      );
      expect(find.byType(HomeView), findsOneWidget);
    });
  });

  group('HomeView', () {
    testWidgets('renders a ConstraintsForm', (tester) async {
      when(() => patternsBloc.state).thenReturn(
        PatternsInitial(),
      );
      await tester.pumpApp(
        patternsBloc: patternsBloc,
        widget: HomeView(),
      );
      expect(find.byType(ConstraintsForm), findsOneWidget);
    });

    group('navigates', () {
      testWidgets('to Attributions when attributions icon is pressed',
          (tester) async {
        when(() => patternsBloc.state).thenReturn(
          PatternsInitial(),
        );
        await tester.pumpApp(
          patternsBloc: patternsBloc,
          widget: HomeView(),
        );
        await tester.tap(find.byKey(attributionsButtonKey));
        await tester.pumpAndSettle();
        expect(find.byType(AttributionsPage), findsOneWidget);
      });

      testWidgets('to search results page when patterns did load',
          (tester) async {
        whenListen(
          patternsBloc,
          Stream.fromIterable(<PatternsState>[
            PatternsLoading(),
            PatternsLoaded([mockPattern]),
          ]),
        );
        when(() => patternsBloc.state).thenReturn(
          PatternsLoaded([mockPattern]),
        );
        await tester.pumpApp(
          patternsBloc: patternsBloc,
          widget: HomeView(),
        );
        await tester.pumpAndSettle();
        expect(find.byType(SearchResultsPage), findsOneWidget);
      });
    });
  });
}
