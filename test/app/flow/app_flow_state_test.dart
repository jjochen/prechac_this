// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter_test/flutter_test.dart';
import 'package:prechac_this/app/flow/app_flow.dart';

import '../../helpers/helpers.dart';

void main() {
  group('AppFlowState', () {
    test('supports value comparisons', () {
      expect(
        AppFlowState(
          listOfPatterns: [mockPattern],
          currentPattern: mockPattern,
          showAttributions: true,
        ),
        AppFlowState(
          listOfPatterns: [mockPattern],
          currentPattern: mockPattern,
          showAttributions: true,
        ),
      );
    });

    group('copyWith()', () {
      test('uses new values', () {
        expect(
          AppFlowState().copyWith(
            listOfPatterns: [mockPattern],
            currentPattern: mockPattern,
            showAttributions: true,
          ),
          AppFlowState(
            listOfPatterns: [mockPattern],
            currentPattern: mockPattern,
            showAttributions: true,
          ),
        );
      });

      test('uses fallback values', () {
        expect(
          AppFlowState(
            listOfPatterns: [mockPattern],
            currentPattern: mockPattern,
            showAttributions: true,
          ).copyWith(),
          AppFlowState(
            listOfPatterns: [mockPattern],
            currentPattern: mockPattern,
            showAttributions: true,
          ),
        );
      });
    });
  });
}
