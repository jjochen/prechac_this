// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/navigation/cubit/navigation_cubit.dart';

import '../../helpers/helpers.dart';

void main() {
  group('NavigationState', () {
    test('supports value comparisons', () {
      expect(NavigationState(), NavigationState());
      expect(
        NavigationState(
          listOfPatterns: [mockPattern],
          currentPattern: mockPattern,
        ),
        NavigationState(
          listOfPatterns: [mockPattern],
          currentPattern: mockPattern,
        ),
      );
    });
  });
}
