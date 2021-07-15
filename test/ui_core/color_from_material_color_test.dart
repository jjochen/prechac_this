// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:prechac_this/ui_core/color_from_material_color.dart';
import 'package:test/test.dart';

void main() {
  group('toMaterialColor()', () {
    test('shade500 is original color', () {
      final color = Color(0x12345678);
      expect(
        color.toMaterialColor().shade500,
        color,
      );
    });

    test('shade05 of white is white', () {
      final color = Color(0xffffffff);
      expect(
        color.toMaterialColor().shade50,
        color,
      );
    });

    test('shade900 of black is black', () {
      final color = Color(0xff000000);
      expect(
        color.toMaterialColor().shade900,
        color,
      );
    });

    test('shade700 of app color', () {
      final color = Color(0xff457b9d);
      expect(
        color.toMaterialColor().shade700,
        Color(0xff37627e),
      );
    });

    test('shade100 of app color', () {
      final color = Color(0xff457b9d);
      expect(
        color.toMaterialColor().shade100,
        Color(0xff8fb0c4),
      );
    });
  });
}
