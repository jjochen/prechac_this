import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/app_router.dart';
import 'package:prechac_this/attributions/attributions.dart';
import 'package:prechac_this/home/home.dart';

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
      testWidgets('empty route', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);
      });

      testWidgets('unknown route', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            initialRoute: 'home',
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);
      });

      testWidgets('attributions route', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            initialRoute: 'attributions',
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
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

    group('home', () {
      test('has route search', () {
        expect(
          RoutingData.home(),
          RoutingData([]),
        );
      });
    });
  });

  group('RoutingDataString', () {
    test('parses route', () {
      final route = 'search/results?number_of_jugglers=2&period=4';
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
