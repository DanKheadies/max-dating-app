import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: const Color(0xFF2B2E4A),
    // primaryColorDark: Color(0xFFFC0028),
    // primaryColorLight: Color(0xFFFE9AAA),
    // accentColor: Color(0xFFE84545),
    scaffoldBackgroundColor: Colors.white,
    // backgroundColor: Color(0xFFF4F4F4),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF2B2E4A),
      secondary: Color(0xFFE84545),
      background: Color(0xFFF4F4F4),
      surface: Color(0xFF669966),
      error: Color(0xFFff0000),
      onPrimary: Color(0xFF000000),
      onSecondary: Color(0xFF000000),
      onBackground: Color(0xFF000000),
      onSurface: Color(0xFF000000),
      onError: Color(0xFF000000),
    ),
    fontFamily: 'Optima',
    textTheme: const TextTheme(
      // headline1
      displayLarge: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      // headline2
      displayMedium: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      // headline3
      displaySmall: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      // headline4
      headlineMedium: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      // headline5
      headlineSmall: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      // headline6
      titleLarge: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      // bodyText1
      bodyLarge: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      // bodyText2
      bodyMedium: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
    ),
  );
}
