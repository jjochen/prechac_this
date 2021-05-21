// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/repositories/pattern_repository/pattern_repository.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

void main() {
  group('LoadPatterns', () {
    final searchParameters = SearchParameters(
      numberOfJugglers: 4,
      period: 3,
      numberOfObjects: 5,
      maxHeight: 3,
    );
    test('supports value comparisons', () {
      expect(
        LoadPatterns(searchParameters),
        LoadPatterns(searchParameters),
      );
    });
  });

  group('PatternsUpdated', () {
    test('supports value comparisons', () {
      expect(
        PatternsUpdated([]),
        PatternsUpdated([]),
      );
    });
  });
}
