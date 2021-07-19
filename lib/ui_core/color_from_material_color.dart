import 'package:flutter/material.dart';

extension ColorToMaterialColor on Color {
  MaterialColor toMaterialColor() {
    final swatch = <int, Color>{};

    const strengths = <double>[
      .05,
      0.1,
      0.2,
      0.3,
      0.4,
      0.5,
      0.6,
      0.7,
      0.8,
      0.9
    ];

    for (final strength in strengths) {
      final ds = 0.5 - strength;
      final shade = _shadeForDistance(ds);
      swatch[(strength * 1000).round()] = shade;
    }
    return MaterialColor(value, swatch);
  }

  Color _shadeForDistance(double ds) {
    final shade = Color.fromRGBO(
      _moveChannel(red, ds),
      _moveChannel(green, ds),
      _moveChannel(blue, ds),
      opacity,
    );
    return shade;
  }

  int _moveChannel(int channel, double ds) {
    return channel + ((ds < 0 ? channel : (255 - channel)) * ds).round();
  }
}
