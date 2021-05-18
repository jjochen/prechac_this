import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/repositories/pattern_repository/models/search_parameters.dart';

void main() {
  group('SearchParameters', () {
    late SearchParameters searchParameters;
    const numberOfJugglers = 3;
    const period = 5;
    const numberOfObjects = 6;
    const maxHeight = 6;
    const minNumberOfPasses = 2;
    const maxNumberOfPasses = 3;

    setUp(() {
      searchParameters = SearchParameters(
        numberOfJugglers: numberOfJugglers,
        period: period,
        numberOfObjects: numberOfObjects,
        maxHeight: maxHeight,
        minNumberOfPasses: minNumberOfPasses,
        maxNumberOfPasses: maxNumberOfPasses,
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
        ),
      );
    });

    test('has correct string representation', () {
      expect(
        searchParameters.toString(),
        'SearchParameters(3, 5, 6, 6, 2, 3)',
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
        ),
        SearchParameters(
          numberOfJugglers: 1,
          period: 2,
          numberOfObjects: 3,
          maxHeight: 5,
          minNumberOfPasses: 6,
          maxNumberOfPasses: 7,
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
