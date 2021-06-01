// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:prechac_this/screens/home/home.dart';

void main() {
  const numberOfJugglers = NumberOfJugglers.dirty(5);
  const period = Period.dirty(3);
  const numberOfObjects = NumberOfObjects.dirty(6);
  const maxHeight = MaxHeight.dirty(7);
  const errorMessage = 'Error Error';

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

    test('returns object with updated error message when message is passed',
        () {
      expect(
        ConstraintsFormState().copyWith(errorMessage: errorMessage),
        ConstraintsFormState(errorMessage: errorMessage),
      );
    });

    test('supports search parameter conversion', () {
      expect(
        ConstraintsFormState(
          numberOfJugglers: numberOfJugglers,
          period: period,
          numberOfObjects: numberOfObjects,
          maxHeight: maxHeight,
        ).toSearchParameters(),
        SearchParameters(
          numberOfJugglers: 5,
          period: 3,
          numberOfObjects: 6,
          maxHeight: 7,
        ),
      );
    });
  });
}
