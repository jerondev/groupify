import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = FlexThemeData.light(
  scheme: FlexScheme.deepPurple,
  textTheme: GoogleFonts.mulishTextTheme(
    ThemeData().textTheme,
  ),
  // useMaterial3: true,
  useMaterial3ErrorColors: true,
  appBarBackground: FlexThemeData.light(scheme: FlexScheme.deepPurple)
      .secondaryHeaderColor
      .withOpacity(0.5),
).copyWith(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      shape: const StadiumBorder(),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      shape: const StadiumBorder(),
    ),
  ),
);

final darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.deepPurple,
  textTheme: GoogleFonts.mulishTextTheme(
    ThemeData.dark().textTheme,
  ),
  // useMaterial3: true,
  useMaterial3ErrorColors: true,
  appBarBackground: ThemeData.dark().navigationBarTheme.backgroundColor,
).copyWith(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      shape: const StadiumBorder(),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      shape: const StadiumBorder(),
    ),
  ),
);
