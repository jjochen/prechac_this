import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/repositories/pattern_repository/core/config_map.dart';

void main() {
  group('ConfigMap', () {
    group('String', () {
      test('Finds correct string value', () {
        final map = {
          'a_key': 23,
          'b_key': 'forty two',
        };
        expect(map.stringForKey('b_key', fallback: '...'), 'forty two');
      });
    });

    group('Uri', () {
      test('Finds correct uri value', () {
        final map = {
          'a_key': 23,
          'b_key': 'https://jochen-pfeiffer.com/index.html',
        };
        final uri = map.tryUriForKey('b_key');
        expect(uri, isNotNull);
        expect(uri?.host, 'jochen-pfeiffer.com');
      });

      test('Uses default value if uri can not be parsed', () {
        final map = {
          'key': 42,
        };
        final uri =
            map.uriForKey('key', fallback: Uri.parse('http://github.com'));
        expect(uri.host, 'github.com');
      });
    });

    group('Bool', () {
      test('Finds correct bool value', () {
        final map = {
          'true_key': true,
          'false_key': false,
        };
        expect(map.boolForKey('true_key', fallback: false), true);
        expect(map.boolForKey('false_key', fallback: true), false);
      });

      test('Finds correct bool value when represented as String', () {
        final map = {
          'true_key': 'true',
          'false_key': 'false',
        };
        expect(map.boolForKey('true_key', fallback: false), true);
        expect(map.boolForKey('false_key', fallback: true), false);
      });

      test('Finds correct bool value when represented as int', () {
        final map = {
          'true_key': 1,
          'false_key': 0,
        };
        expect(map.boolForKey('true_key', fallback: false), true);
        expect(map.boolForKey('false_key', fallback: true), false);
      });
    });

    group('int', () {
      test('Finds correct int value', () {
        final map = {
          'a_key': 23,
          'b_key': 'forty two',
        };
        expect(map.intForKey('a_key', fallback: 2), 23);
      });

      test('Finds correct int value when represented as string', () {
        final map = {
          'a_key': '23',
          'b_key': 'forty two',
        };
        expect(map.intForKey('a_key', fallback: 2), 23);
      });
    });

    group('Double', () {
      test('Finds correct double value', () {
        final map = {
          'a_key': 23.5,
          'b_key': 'forty two',
        };
        expect(map.doubleForKey('a_key', fallback: 2), 23.5);
      });

      test('Finds correct double value when represented as string', () {
        final map = {
          'a_key': '23.5',
          'b_key': 'forty two',
        };
        expect(map.doubleForKey('a_key', fallback: 2), 23.5);
      });
    });
  });
}
