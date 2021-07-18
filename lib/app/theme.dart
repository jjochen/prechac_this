import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData.from(
  textTheme: GoogleFonts.openSansTextTheme(
    ThemeData.light().textTheme,
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xff447212),
    primaryVariant: Color(0xff26410a),
    onPrimary: Colors.white,
    secondary: Color(0xff661872),
    secondaryVariant: Color(0xff3b0e42),
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    background: Color(0xfff8fff1),
    onBackground: Colors.black,
    error: Color(0xffa31a24),
    onError: Colors.white,
  ),
);

final darkTheme = ThemeData.from(
  textTheme: GoogleFonts.openSansTextTheme(
    ThemeData.dark().textTheme,
  ),
  colorScheme: ColorScheme.dark(
    primary: const Color(0xff447212),
    primaryVariant: Colors.black,
    onPrimary: Colors.white,
    secondary: const Color(0xff661872),
    secondaryVariant: const Color(0xff3b0e42),
    onSecondary: Colors.white,
    surface: Colors.grey[800]!,
    onSurface: Colors.white,
    background: Colors.grey[700]!,
    onBackground: Colors.white,
    error: const Color(0xffa31a24),
    onError: Colors.black,
  ),
);

extension CustomColorScheme on ColorScheme {
  Color get classicThrowColor => _currentColor(
        const Color(0xff2133a7),
        const Color(0xff2133a7),
      );
  Color get equiThrowColor => _currentColor(
        const Color(0xffa31a24),
        const Color(0xffa31a24),
      );
  Color get biThrowColor => _currentColor(
        const Color(0xff661872),
        const Color(0xff661872),
      );
  Color get instantBiThrowColor => _currentColor(
        const Color(0xff447212),
        const Color(0xff447212),
      );

  Color _currentColor(Color lightColor, Color darkColor) =>
      brightness == Brightness.dark ? darkColor : lightColor;
}
