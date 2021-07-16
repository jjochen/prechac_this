import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ui_core/ui_core.dart';

final lightTheme = ThemeData.from(
  textTheme: GoogleFonts.openSansTextTheme(
    ThemeData.light().textTheme,
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xff457b9d),
    primaryVariant: Color(0xff1d3557),
    onPrimary: Colors.white,
    secondary: Color(0xffe63946),
    secondaryVariant: Color(0xffa32831),
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    background: Color(0xffe5eef4),
    onBackground: Colors.black,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.openSansTextTheme(
    ThemeData.dark().textTheme,
  ),
  primarySwatch: const Color(0xff457b9d).toMaterialColor(),
);

extension CustomColorScheme on ColorScheme {
  Color get classicThrowColor => _currentColor(
        const Color(0xff007aff),
        const Color(0xff0a84ff),
      );
  Color get equiThrowColor => _currentColor(
        const Color(0xffff3b30),
        const Color(0xffff453a),
      );
  Color get biThrowColor => _currentColor(
        const Color(0xff800080),
        const Color(0xffbf5af2),
      );
  Color get instantBiThrowColor => _currentColor(
        const Color(0xff008000),
        const Color(0xff30d158),
      );

  Color _currentColor(Color lightColor, Color darkColor) =>
      brightness == Brightness.dark ? darkColor : lightColor;
}
