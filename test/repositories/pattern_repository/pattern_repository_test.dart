import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/repositories/pattern_repository/pattern_repository.dart';

void main() {
  group('PatternRepository', () {
    late PatternRepository patternRepository;
    setUp(() {
      patternRepository = PatternRepository();
    });

    test('findes correct for search parameters', () async {
      final searchParameters = SearchParameters(
        numberOfJugglers: 2,
        period: 2,
        numberOfObjects: 4,
        maxHeight: 4,
        minNumberOfPasses: 1,
        maxNumberOfPasses: 2,
      );
      expect(
          patternRepository.patterns(searchParameters).then((pattern) {
            expect(pattern, [
              Pattern([Throw.pass(height: 2), Throw.pass(height: 2)]),
              Pattern([Throw.pass(height: 3), Throw.pass(height: 1)]),
            ]);
          }),
          completes);
    });

    test('prechac this throw up', () {
      final pattern = Pattern([
        Throw.self(height: 4),
        Throw.pass(height: 2),
        Throw.self(height: 1),
        Throw.pass(height: 1),
      ]);
      expect(
          patternRepository.prechacThisThrow(
            pattern: pattern,
            index: 1,
            direction: PrechacDirection.up,
            numberOfJugglers: 2,
          ),
          Pattern([
            Throw.self(height: 4),
            Throw.self(height: 4),
            Throw.self(height: 1),
            Throw.pass(height: 1),
          ]));
    });

    test('prechac this throw down', () {
      final pattern = Pattern([
        Throw.self(height: 4),
        Throw.pass(height: 2),
        Throw.self(height: 1),
        Throw.pass(height: 1),
      ]);
      expect(
          patternRepository.prechacThisThrow(
            pattern: pattern,
            index: 0,
            direction: PrechacDirection.down,
            numberOfJugglers: 2,
          ),
          Pattern([
            Throw.pass(height: 2),
            Throw.pass(height: 2),
            Throw.self(height: 1),
            Throw.pass(height: 1),
          ]));
    });
  });
}
