import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ui_core/ui_core.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: GoogleFonts.openSansTextTheme(
    ThemeData.light().textTheme,
  ),
  primarySwatch: const Color(0xff457b9d).toMaterialColor(),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: GoogleFonts.openSansTextTheme(
    ThemeData.dark().textTheme,
  ),
  primarySwatch: const Color(0xff457b9d).toMaterialColor(),
);

extension CustomColorScheme on ColorScheme {
  // TODO: dark theme colors
  Color get classicThrowColor => const Color(0xff0000ff);
  Color get equiThrowColor => const Color(0xffff0000);
  Color get biThrowColor => const Color(0xff800080);
  Color get instantBiThrowColor => const Color(0xff008000);
}
