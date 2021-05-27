import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

import '../helpers/helpers.dart';

void main() {
  group('PatternsRepository', () {
    late PatternsRepository patternsRepository;
    setUp(() {
      patternsRepository = PatternsRepository();
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
          patternsRepository.patterns(searchParameters).then((pattern) {
            expect(pattern, [
              Pattern([Throw.pass(height: 3), Throw.pass(height: 1)]),
              Pattern([Throw.pass(height: 2), Throw.pass(height: 2)]),
            ]);
          }),
          completes);
    });

    test('prechac this throw up', () {
      expect(
          patternsRepository.prechacThisThrow(
            pattern: mockPattern,
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
      expect(
          patternsRepository.prechacThisThrow(
            pattern: mockPattern,
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