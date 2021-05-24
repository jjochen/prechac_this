// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/screens/search_results/search_results.dart';

void main() {
  group('PatternsInitial', () {
    test('supports value comparisons', () {
      expect(PatternsInitial(), PatternsInitial());
    });
  });

  group('PatternsLoading', () {
    test('supports value comparisons', () {
      expect(PatternsLoading(), PatternsLoading());
    });
  });
  group('PatternsLoaded', () {
    test('supports value comparisons', () {
      expect(PatternsLoaded(), PatternsLoaded());
    });
  });

  group('PatternsNotLoaded', () {
    test('supports value comparisons', () {
      expect(PatternsNotLoaded(), PatternsNotLoaded());
    });
  });
}