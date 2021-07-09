import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  primaryColorDark: const Color(0xff1d3557),
  primaryColorLight: const Color(0xffa8dadc),
  primaryColor: const Color(0xff457b9d),
  accentColor: const Color(0xffe63946),
  scaffoldBackgroundColor: const Color(0xfff1faee),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);

extension CustomColorScheme on ColorScheme {
  Color get classicThrowColor => const Color(0xff0000ff);
  Color get equiThrowColor => const Color(0xffff0000);
  Color get biThrowColor => const Color(0xff800080);
  Color get instantBiThrowColor => const Color(0xff008000);
}


// e63946,f1faee,a8dadc,457b9d,1d3557