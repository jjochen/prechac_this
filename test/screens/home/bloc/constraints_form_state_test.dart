// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:prechac_this/screens/home/home.dart';

void main() {
  const numberOfJugglers = NumberOfJugglers.dirty(5);
  const period = Period.dirty(3);
  const numberOfObjects = NumberOfObjects.dirty(6);
  const maxHeight = MaxHeight.dirty(7);
  const minNumberOfPasses = MinNumberOfPasses.dirty(8);
  const maxNumberOfPasses = MaxNumberOfPasses.dirty(9);
  const contains = Contains.dirty('yo');
  final exception = Exception('Error');

  group('ConstraintsFormState', () {
    test('supports value comparisons', () {
      expect(ConstraintsFormState(), ConstraintsFormState());
    });

    test('returns same object when no properties are passed', () {
      expect(ConstraintsFormState().copyWith(), ConstraintsFormState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        ConstraintsFormState().copyWith(status: FormzStatus.valid),
        ConstraintsFormState(status: FormzStatus.valid),
      );
    });

    test(
        'returns object with updated numberOfJugglers '
        'when numberOfJugglers is passed', () {
      expect(
        ConstraintsFormState().copyWith(numberOfJugglers: numberOfJugglers),
        ConstraintsFormState(numberOfJugglers: numberOfJugglers),
      );
    });

    test('returns object with updated period when period is passed', () {
      expect(
        ConstraintsFormState().copyWith(period: period),
        ConstraintsFormState(period: period),
      );
    });

    test(
        'returns object with updated numberOfObjects '
        'when numberOfObjects is passed', () {
      expect(
        ConstraintsFormState().copyWith(numberOfObjects: numberOfObjects),
        ConstraintsFormState(numberOfObjects: numberOfObjects),
      );
    });

    test('returns object with updated maxHeight when maxHeight is passed', () {
      expect(
        ConstraintsFormState().copyWith(maxHeight: maxHeight),
        ConstraintsFormState(maxHeight: maxHeight),
      );
    });

    test(
        'returns object with updated minNumberOfPasses '
        'when minNumberOfPasses is passed', () {
      expect(
        ConstraintsFormState().copyWith(minNumberOfPasses: minNumberOfPasses),
        ConstraintsFormState(minNumberOfPasses: minNumberOfPasses),
      );
    });

    test(
        'returns object with updated maxNumberOfPasses '
        'when maxNumberOfPasses is passed', () {
      expect(
        ConstraintsFormState().copyWith(maxNumberOfPasses: maxNumberOfPasses),
        ConstraintsFormState(maxNumberOfPasses: maxNumberOfPasses),
      );
    });

    test(
        'returns object with updated contains '
        'when contains is passed', () {
      expect(
        ConstraintsFormState().copyWith(contains: contains),
        ConstraintsFormState(contains: contains),
      );
    });

    test('returns object with updated error when error is passed', () {
      final actual = ConstraintsFormState().copyWith(exception: exception);
      final expected = ConstraintsFormState(exception: exception);
      expect(actual, expected);
      expect(actual.exception, expected.exception);
    });

    test('supports search parameter conversion', () {
      expect(
        ConstraintsFormState(
          numberOfJugglers: numberOfJugglers,
          period: period,
          numberOfObjects: numberOfObjects,
          maxHeight: maxHeight,
          minNumberOfPasses: minNumberOfPasses,
          maxNumberOfPasses: maxNumberOfPasses,
          contains: contains,
        ).toSearchParameters(),
        SearchParameters(
          numberOfJugglers: 5,
          period: 3,
          numberOfObjects: 6,
          maxHeight: 7,
          minNumberOfPasses: 8,
          maxNumberOfPasses: 9,
          contains: 'yo',
        ),
      );
    });
  });
}
