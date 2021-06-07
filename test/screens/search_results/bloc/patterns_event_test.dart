// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/patterns_bloc/patterns_bloc.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

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
