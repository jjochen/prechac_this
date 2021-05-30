// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/screens/home/home.dart';

void main() {
  group('ConstraintsFormEvent', () {
    group('NumberOfJugglersDidChange', () {
      test('supports value comparisons', () {
        expect(
          NumberOfJugglersDidChange(3),
          NumberOfJugglersDidChange(3),
        );
      });
    });

    group('PeriodDidChange', () {
      test('supports value comparisons', () {
        expect(
          PeriodDidChange(1),
          PeriodDidChange(1),
        );
      });
    });

    group('NumberOfObjectsDidChange', () {
      test('supports value comparisons', () {
        expect(
          NumberOfObjectsDidChange(2),
          NumberOfObjectsDidChange(2),
        );
      });
    });

    group('MaxHeightDidChange', () {
      test('supports value comparisons', () {
        expect(
          MaxHeightDidChange(7),
          MaxHeightDidChange(7),
        );
      });
    });

    group('MinNumberOfPassesDidChange', () {
      test('supports value comparisons', () {
        expect(
          MinNumberOfPassesDidChange(7),
          MinNumberOfPassesDidChange(7),
        );
      });
    });

    group('MaxNumberOfPassesDidChange', () {
      test('supports value comparisons', () {
        expect(
          MaxNumberOfPassesDidChange(7),
          MaxNumberOfPassesDidChange(7),
        );
      });
    });

    group('Submit', () {
      test('supports value comparisons', () {
        expect(
          Submit(),
          Submit(),
        );
      });
    });

    group('PattersDidLoad', () {
      test('supports value comparisons', () {
        expect(
          PattersDidLoad(),
          PattersDidLoad(),
        );
      });
    });

    group('PattersDidNotLoad', () {
      test('supports value comparisons', () {
        expect(
          PattersDidNotLoad('message'),
          PattersDidNotLoad('message'),
        );
      });
    });
  });
}
