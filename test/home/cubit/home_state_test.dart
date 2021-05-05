// ignore_for_file: prefer_const_constructors
import 'package:prechac_this/home/home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:prechac_this/home/models/number_of_jugglers.dart';

void main() {
  const numberOfJugglers = NumberOfJugglers.dirty(5);
  const period = Period.dirty(3);
  const numberOfObjects = NumberOfObjects.dirty(6);
  const maxHeight = MaxHeight.dirty(7);

  group('HomeState', () {
    test('supports value comparisons', () {
      expect(HomeState(), HomeState());
    });

    test('returns same object when no properties are passed', () {
      expect(HomeState().copyWith(), HomeState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        HomeState().copyWith(status: FormzStatus.valid),
        HomeState(status: FormzStatus.valid),
      );
    });

    test(
        'returns object with updated numberOfJugglers '
        'when numberOfJugglers is passed', () {
      expect(
        HomeState().copyWith(numberOfJugglers: numberOfJugglers),
        HomeState(numberOfJugglers: numberOfJugglers),
      );
    });

    test('returns object with updated period when period is passed', () {
      expect(
        HomeState().copyWith(period: period),
        HomeState(period: period),
      );
    });

    test(
        'returns object with updated numberOfObjects '
        'when numberOfObjects is passed', () {
      expect(
        HomeState().copyWith(numberOfObjects: numberOfObjects),
        HomeState(numberOfObjects: numberOfObjects),
      );
    });

    test('returns object with updated maxHeight when maxHeight is passed', () {
      expect(
        HomeState().copyWith(maxHeight: maxHeight),
        HomeState(maxHeight: maxHeight),
      );
    });
  });
}