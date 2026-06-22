import 'package:flutter/material.dart';
import 'design_tokens.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: kPaper,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: kInk,
        onPrimary: kPaper,
        secondary: kInk,
        onSecondary: kPaper,
        error: Color(0xFFB00020),
        onError: Colors.white,
        surface: Colors.white,
        onSurface: kInk,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: kInk,
          fontWeight: FontWeight.w900,
          fontSize: 48,
          letterSpacing: -1.5,
          height: 1.0,
        ),
        displayMedium: TextStyle(
          color: kInk,
          fontWeight: FontWeight.w800,
          fontSize: 34,
          letterSpacing: -1.0,
          height: 1.1,
        ),
        headlineLarge: TextStyle(
          color: kInk,
          fontWeight: FontWeight.w800,
          fontSize: 28,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          color: kInk,
          fontWeight: FontWeight.w700,
          fontSize: 22,
          letterSpacing: -0.3,
        ),
        titleLarge: TextStyle(
          color: kInk,
          fontWeight: FontWeight.w700,
          fontSize: 18,
          letterSpacing: -0.2,
        ),
        titleMedium: TextStyle(
          color: kInk,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        bodyLarge: TextStyle(color: kInk, fontSize: 15, height: 1.6),
        bodyMedium: TextStyle(color: kMuted, fontSize: 13, height: 1.5),
        labelSmall: TextStyle(
          color: kMuted,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: kPaper,
        foregroundColor: kInk,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: kInk,
          fontWeight: FontWeight.w800,
          fontSize: 17,
          letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(color: kInk),
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: kBorder),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        color: kBorder,
        thickness: 1,
        space: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kInk,
          foregroundColor: kPaper,
          minimumSize: const Size(double.infinity, 52),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          elevation: 0,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 1.2,
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: kBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: kBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: kInk, width: 2),
        ),
        hintStyle: TextStyle(color: kMuted, fontSize: 14),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      iconTheme: const IconThemeData(color: kInk),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: kVoid,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.white,
        onPrimary: kVoid,
        secondary: kNeonTeal,
        onSecondary: kVoid,
        error: Color(0xFFCF6679),
        onError: kVoid,
        surface: kSurface,
        onSurface: Colors.white,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 48,
          letterSpacing: -1.5,
          height: 1.0,
        ),
        displayMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 34,
          letterSpacing: -1.0,
          height: 1.1,
        ),
        headlineLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 28,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 22,
          letterSpacing: -0.3,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
          letterSpacing: -0.2,
        ),
        titleMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        bodyLarge: TextStyle(color: Colors.white, fontSize: 15, height: 1.6),
        bodyMedium: TextStyle(color: kMutedDark, fontSize: 13, height: 1.5),
        labelSmall: TextStyle(
          color: kMutedDark,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: kVoid,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 17,
          letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: const CardThemeData(
        color: kSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: kSubtle),
        ),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: const DividerThemeData(
        color: kSubtle,
        thickness: 1,
        space: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: kVoid,
          minimumSize: const Size(double.infinity, 52),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          elevation: 0,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 1.2,
          ),
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: kSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: kSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: kSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        hintStyle: TextStyle(color: kMutedDark, fontSize: 14),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
