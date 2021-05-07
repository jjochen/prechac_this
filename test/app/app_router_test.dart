import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/app_router.dart';

void main() {
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
          RoutingData(['search']),
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
