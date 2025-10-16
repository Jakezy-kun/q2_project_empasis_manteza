import 'dart:js_interop';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'onboarding.dart';


void main() async {

  runApp(DevicePreview(builder: (context)=>ByteBackApp()));

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );


}

class ByteBackApp extends StatefulWidget {
  const ByteBackApp({super.key});

  @override
  State<ByteBackApp> createState() => _ByteBackAppState();
}

class _ByteBackAppState extends State<ByteBackApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReBooted',
      theme: isDarkMode ? _buildDarkTheme() : _buildLightTheme(),
      home: OnboardingScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF109991),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF109991),
        secondary: Color(0xFF148846),
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF109991),
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF109991),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF109991),
        secondary: Color(0xFF148846),
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        selectedItemColor: Color(0xFF109991),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}