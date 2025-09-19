import 'package:flutter/material.dart';

const Color primaryGreen = Color(0xFF109991);
const Color tealAlternative = Color(0xFF148846);
const Color navyBlue = Color(0xFF07722A);
const Color accentYellow = Color(0xFFFBBE2A);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryGreen,
  colorScheme: const ColorScheme.light(
    primary: primaryGreen,
    secondary: tealAlternative,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: primaryGreen,
    unselectedItemColor: Colors.grey,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryGreen,
  colorScheme: const ColorScheme.dark(
    primary: primaryGreen,
    secondary: tealAlternative,
  ),
  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1E1E1E),
    selectedItemColor: primaryGreen,
    unselectedItemColor: Colors.grey,
  ),
);