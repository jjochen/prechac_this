import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: GoogleFonts.openSansTextTheme(
    ThemeData.light().textTheme,
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xff457b9d),
    primaryVariant: Color(0xff1d3557),
    onPrimary: Colors.white,
    secondary: Color(0xff7a2e70),
    secondaryVariant: Color(0xff9b3a8f),
    onSecondary: Colors.white,
    error: Color(0xffe63946),
    onError: Colors.white,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.openSansTextTheme(
    ThemeData.dark().textTheme,
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xff457b9d),
    primaryVariant: Color(0xff1d3557),
    onPrimary: Colors.white,
    secondary: Color(0xff7a2e70),
    secondaryVariant: Color(0xff9b3a8f),
    onSecondary: Colors.white,
    error: Color(0xffe63946),
    onError: Colors.white,
  ),
);

extension CustomColorScheme on ColorScheme {
  Color get classicThrowColor => const Color(0xff0000ff);
  Color get equiThrowColor => const Color(0xffff0000);
  Color get biThrowColor => const Color(0xff800080);
  Color get instantBiThrowColor => const Color(0xff008000);
}

// e63946,f1faee,a8dadc,457b9d,1d3557
