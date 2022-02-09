import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prechac_this/ui_core/ui_core.dart';

final lightTheme = ThemeData.from(
  textTheme: GoogleFonts.openSansTextTheme(
    ThemeData.light().textTheme,
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xff2b801a),
    onPrimary: Colors.white,
    secondary: Color(0xff801a6f),
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    background: Color(0xfff5fff3),
    onBackground: Colors.black,
    error: Color(0xffcc2944),
    onError: Colors.white,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.openSansTextTheme(
    ThemeData.dark().textTheme,
  ),
  primarySwatch: const Color(0xff399926).toMaterialColor(),
);

extension CustomColorScheme on ColorScheme {
  Color get selfThrowColor => _currentColor(
        const Color(0xff0D0D0D),
        const Color(0xffF2F2F2),
      );
  Color get classicThrowColor => _currentColor(
        const Color(0xff2929CC),
        const Color(0xff5959FF),
      );
  Color get equiThrowColor => _currentColor(
        const Color(0xffCC2929),
        const Color(0xffE63939),
      );
  Color get biThrowColor => _currentColor(
        const Color(0xff801A6F),
        const Color(0xffB32C9C),
      );
  Color get instantBiThrowColor => _currentColor(
        const Color(0xff2B801A),
        const Color(0xff399926),
      );

  Color _currentColor(Color lightColor, Color darkColor) =>
      brightness == Brightness.dark ? darkColor : lightColor;
}
