import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = FlexThemeData.light(
  scheme: FlexScheme.deepPurple,
  textTheme: GoogleFonts.mulishTextTheme(
    ThemeData().textTheme,
  ),
  useMaterial3ErrorColors: true,
  appBarStyle: FlexAppBarStyle.surface,
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
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(90),
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 18,
      horizontal: 18,
    ),
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(
    constraints: const BoxConstraints(
      minWidth: 40,
      minHeight: 35,
    ),
    borderRadius: BorderRadius.circular(100),
  ),
);

final darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.deepPurple,
  textTheme: GoogleFonts.mulishTextTheme(
    ThemeData.dark().textTheme,
  ),
  useMaterial3ErrorColors: true,
  appBarStyle: FlexAppBarStyle.background,
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
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(90),
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 18,
      horizontal: 18,
    ),
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(
    constraints: const BoxConstraints(
      minWidth: 40,
      minHeight: 35,
    ),
    borderRadius: BorderRadius.circular(100),
  ),
);
