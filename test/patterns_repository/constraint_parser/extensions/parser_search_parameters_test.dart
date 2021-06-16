// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:prechac_this/patterns_repository/constraint_parser/extensions/parser_search_parameters.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:test/test.dart';

void main() {
  group('ParserSearchParameters', () {
    test('parsed correctly', () {
      expect(
        SearchParameters(
          numberOfJugglers: 2,
          period: 4,
          numberOfObjects: 7,
          maxHeight: 5,
          minNumberOfPasses: 6,
          maxNumberOfPasses: 7,
          contains: '3 3 _p 1 _ 3',
        ).parse(),
        PatternConstraint(
          numberOfJugglers: 2,
          numberOfObjects: 7,
          maxHeight: 5,
          minNumberOfPasses: 6,
          maxNumberOfPasses: 7,
          throwSequence: [
            ThrowConstraint.self(height: 3),
            ThrowConstraint.self(height: 3),
            ThrowConstraint.pass(height: null),
            ThrowConstraint.self(height: 1),
          ],
        ),
      );
    });
  });
}
