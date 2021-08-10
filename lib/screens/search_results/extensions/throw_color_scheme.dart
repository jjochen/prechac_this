import 'package:flutter/material.dart';
import 'package:prechac_this/app/theme.dart';
import 'package:prechac_this/patterns_repository/patterns_repository.dart';

extension ThrowColorScheme on ColorScheme {
  Color colorForStyle(ThrowStyle style) {
    switch (style) {
      case ThrowStyle.self:
        return selfThrowColor;

      case ThrowStyle.classic:
        return classicThrowColor;

      case ThrowStyle.equi:
        return equiThrowColor;

      case ThrowStyle.bi:
        return biThrowColor;

      case ThrowStyle.instantBi:
        return instantBiThrowColor;
    }
  }
}
