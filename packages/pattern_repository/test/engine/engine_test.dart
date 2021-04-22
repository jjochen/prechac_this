import 'package:pattern_repository/pattern_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pattern_repository/src/engine/engine.dart';

void main() {
  group('Engine', () {
    group('4 1.3p1 _ 1.6p2', () {
      late Pattern pattern;
      late Engine engine;
      setUp(() {
        engine = Engine(
          numberOfJugglers: 3,
          period: 4,
          numberOfObjects: 4,
          maxHeight: 4,
        );
        pattern = Pattern([
          Throw.self(height: 4),
          Throw(height: 4 / 3, passingIndex: 1),
          Throw.placeholder(),
          Throw(height: 5 / 3, passingIndex: 2),
        ]);
      });

      test('calculates landing sites', () {
        expect(
          engine.landingSites(pattern),
          [0, 1, -1, 2],
        );
      });

      test('calculates missing landing sites', () {
        expect(
          engine.missingLandingSites(pattern),
          [3],
        );
      });
    });

    group('4 _ 1 _', () {
      late Pattern pattern;
      late Engine engine;
      setUp(() {
        engine = Engine(
          numberOfJugglers: 2,
          period: 4,
          numberOfObjects: 4,
          maxHeight: 4,
        );
        pattern = Pattern([
          Throw.self(height: 4),
          Throw.placeholder(),
          Throw.self(height: 1),
          Throw.placeholder(),
        ]);
      });

      test('calculates landing sites', () {
        expect(
          engine.landingSites(pattern),
          [0, -1, 3, -1],
        );
      });

      test('calculates missing landing sites', () {
        expect(
          engine.missingLandingSites(pattern),
          [1, 2],
        );
      });

      test('fetches empty stream of numbers', () async {
        await expectLater(
            engine.patterns(),
            emitsInOrder([
              [
                Pattern([
                  Throw.self(height: 4),
                  Throw(height: 2, passingIndex: 1),
                  Throw.self(height: 1),
                  Throw(height: 1, passingIndex: 1),
                ]),
              ]
            ]));
      });
    });
  });
}
