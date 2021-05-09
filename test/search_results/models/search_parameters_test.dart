import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/search_results/models/search_parameters.dart';

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

    test('uses null values when copying', () {
      expect(
        searchParameters.copyWith(
          minNumberOfPasses: null,
          maxNumberOfPasses: null,
        ),
        SearchParameters(
          numberOfJugglers: numberOfJugglers,
          period: period,
          numberOfObjects: numberOfObjects,
          maxHeight: maxHeight,
          minNumberOfPasses: null,
          maxNumberOfPasses: null,
        ),
      );
    });

    test('supports map representation', () {
      expect(
        SearchParameters.fromMap(searchParameters.toMap()),
        searchParameters,
      );
    });

    test('supports json representation', () {
      expect(
        SearchParameters.fromJson(searchParameters.toJson()),
        searchParameters,
      );
    });
  });
}
