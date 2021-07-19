// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:prechac_this/app/theme.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';
import 'package:prechac_this/screens/search_results/extensions/throw_color_scheme.dart';
import 'package:test/test.dart';

void main() {
  group('ThrowColorScheme', () {
    group('dark', () {
      late ColorScheme scheme;
      setUp(() {
        scheme = ColorScheme.dark();
      });

      test('self', () {
        expect(
          scheme.colorForStyle(ThrowStyle.self),
          scheme.onBackground,
        );
      });

      test('classic', () {
        expect(
          scheme.colorForStyle(ThrowStyle.classic),
          scheme.classicThrowColor,
        );
      });

      test('equi', () {
        expect(
          scheme.colorForStyle(ThrowStyle.equi),
          scheme.equiThrowColor,
        );
      });

      test('bi', () {
        expect(
          scheme.colorForStyle(ThrowStyle.bi),
          scheme.biThrowColor,
        );
      });

      test('instantBi', () {
        expect(
          scheme.colorForStyle(ThrowStyle.instantBi),
          scheme.instantBiThrowColor,
        );
      });
    });

    group('light', () {
      late ColorScheme scheme;
      setUp(() {
        scheme = ColorScheme.light();
      });

      test('self', () {
        expect(
          scheme.colorForStyle(ThrowStyle.self),
          scheme.onBackground,
        );
      });

      test('classic', () {
        expect(
          scheme.colorForStyle(ThrowStyle.classic),
          scheme.classicThrowColor,
        );
      });

      test('equi', () {
        expect(
          scheme.colorForStyle(ThrowStyle.equi),
          scheme.equiThrowColor,
        );
      });

      test('bi', () {
        expect(
          scheme.colorForStyle(ThrowStyle.bi),
          scheme.biThrowColor,
        );
      });

      test('instantBi', () {
        expect(
          scheme.colorForStyle(ThrowStyle.instantBi),
          scheme.instantBiThrowColor,
        );
      });
    });
  });
}
