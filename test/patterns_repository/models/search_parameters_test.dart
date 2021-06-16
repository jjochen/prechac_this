// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:prechac_this/patterns_repository/models/search_parameters.dart';
import 'package:test/test.dart';

void main() {
  group('SearchParameters', () {
    late SearchParameters searchParameters;
    const numberOfJugglers = 3;
    const period = 5;
    const numberOfObjects = 6;
    const maxHeight = 6;
    const minNumberOfPasses = 2;
    const maxNumberOfPasses = 3;
    const contains = '4 2p';

    setUp(() {
      searchParameters = SearchParameters(
        numberOfJugglers: numberOfJugglers,
        period: period,
        numberOfObjects: numberOfObjects,
        maxHeight: maxHeight,
        minNumberOfPasses: minNumberOfPasses,
        maxNumberOfPasses: maxNumberOfPasses,
        contains: contains,
      );
    });

    test('supports value comparisons', () {
      expect(
        searchParameters,
        SearchParameters(
          numberOfJugglers: numberOfJugglers,
          period: period,
          numberOfObjects: numberOfObjects,
          maxHeight: maxHeight,
          minNumberOfPasses: minNumberOfPasses,
          maxNumberOfPasses: maxNumberOfPasses,
          contains: contains,
        ),
      );
    });

    test('has correct string representation', () {
      expect(
        searchParameters.toString(),
        'SearchParameters(3, 5, 6, 6, 2, 3, 4 2p)',
      );
    });

    test('keeps unchanged values when copying', () {
      expect(
        searchParameters.copyWith(),
        searchParameters,
      );
    });

    test('uses new values when copying', () {
      expect(
        searchParameters.copyWith(
          numberOfJugglers: 1,
          period: 2,
          numberOfObjects: 3,
          maxHeight: 5,
          minNumberOfPasses: 6,
          maxNumberOfPasses: 7,
          contains: '3 3',
        ),
        SearchParameters(
          numberOfJugglers: 1,
          period: 2,
          numberOfObjects: 3,
          maxHeight: 5,
          minNumberOfPasses: 6,
          maxNumberOfPasses: 7,
          contains: '3 3',
        ),
      );
    });

    test('supports query parameter map representation', () {
      expect(
        SearchParameters.fromQueryParameters(
          searchParameters.toQueryParameters(),
        ),
        searchParameters,
      );
    });
  });
}
