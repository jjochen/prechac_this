// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prechac_this/navigation/app_router.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/screens/attributions/attributions.dart';
import 'package:prechac_this/screens/home/home.dart';

import '../helpers/helpers.dart';

void main() {
  group('AppRouter', () {
    group('generates route', () {
      test('for empty route name', () {
        expect(
          AppRouter.generateRoute(const RouteSettings()),
          isNotNull,
        );
      });
    });

    group('renders page for', () {
      late PatternsBloc patternsBloc;

      setUp(() {
        registerFallbackValue(FakePatternsEvent());
        registerFallbackValue(PatternsInitial());
        patternsBloc = MockPatternsBloc();

        when(() => patternsBloc.state).thenReturn(
          PatternsInitial(),
        );
      });

      testWidgets('empty route', (tester) async {
        await tester.pumpApp(route: null, patternsBloc: patternsBloc);
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);
      });

      testWidgets('unknown route', (tester) async {
        await tester.pumpApp(route: 'whaaaaaat?', patternsBloc: patternsBloc);
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);
      });

      testWidgets('attributions route', (tester) async {
        await tester.pumpApp(route: AttributionsPage.routeName);
        await tester.pumpAndSettle();
        expect(find.byType(AttributionsPage), findsOneWidget);
      });
    });
  });

  group('RoutingData', () {
    late RoutingData routingData;
    setUp(() {
      routingData = RoutingData(
        ['part1', 'part2'],
        {
          'parameter1': 'value1',
          'parameter2': 'value2',
        },
      );
    });

    test('supports value comparisons', () {
      expect(
        routingData,
        RoutingData(
          ['part1', 'part2'],
          {
            'parameter1': 'value1',
            'parameter2': 'value2',
          },
        ),
      );
    });

    test('generates full route', () {
      expect(
        routingData.fullRoute,
        'part1/part2?parameter1=value1&parameter2=value2',
      );
    });

    test('returns parameter', () {
      expect(
        routingData['parameter1'],
        'value1',
      );
    });
  });

  group('RoutingDataString', () {
    test('parses route', () {
      const route = 'search/results?number_of_jugglers=2&period=4';
      expect(
        route.routingData,
        RoutingData([
          'search',
          'results'
        ], {
          'number_of_jugglers': '2',
          'period': '4',
        }),
      );
    });
  });
}
