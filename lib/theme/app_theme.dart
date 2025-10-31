import 'package:flutter/material.dart';

class MyAppTheme {
  // Professional Purple Color Palette
  static const Color primaryPurple = Color(0xFF6B46C1); 
  static const Color secondaryPurple = Color(
    0xFF9F7AEA,
  ); // Lighter accent purple
  static const Color darkPurple = Color(0xFF553C9A); 
  static const Color lightPurple = Color(
    0xFFE9D8FD,
  ); // Very light purple for backgrounds
  static const Color accentPurple = Color(0xFFB794F4);

  // Main theme colors
  static const Color mainFontColor = Color(
    0xFF6B46C1,
  ); // Primary purple for text
  static const Color borderColor = Color(
    0xFF9F7AEA,
  ); // Secondary purple for borders

  // Standard colors
  static const Color blackColor = Color(0xFF1A202C);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color backgroundColor = Color(
    0xFFF7FAFC,
  ); // Light gray background
  static const Color surfaceColor = Color(0xFFFFFFFF);

  // Complete Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: primaryPurple,
        secondary: secondaryPurple,
        tertiary: accentPurple,
        surface: surfaceColor,
        error: Color(0xFFE53E3E),
        onPrimary: whiteColor,
        onSecondary: whiteColor,
        onSurface: blackColor,
        onError: whiteColor,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryPurple,
        foregroundColor: whiteColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: whiteColor),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple,
          foregroundColor: whiteColor,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),


      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: primaryPurple,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: primaryPurple,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primaryPurple,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkPurple,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: blackColor),
        bodyMedium: TextStyle(fontSize: 14, color: blackColor),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: primaryPurple, size: 24),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryPurple,
        foregroundColor: whiteColor,
        elevation: 4,
      ),
    );
  }
}
