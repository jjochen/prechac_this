import 'package:pattern_repository/pattern_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PatternRepository', () {
    late PatternRepository patternRepository;
    setUp(() {
      patternRepository = PatternRepository();
    });

    group('4 _ 1 _', () {
      test('fetches empty stream of numbers', () async {
        await expectLater(
            patternRepository.patterns(
              numberOfJugglers: 2,
              period: 4,
              numberOfObjects: 4,
              maxHeight: 4,
              minNumberOfPasses: 1,
              maxNumberOfPasses: 2,
            ),
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
