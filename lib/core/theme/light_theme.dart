import 'package:flutter/material.dart';
import '../config/constants/color_manager.dart';

abstract final class LightTheme {
  static ThemeData get theme {
    final scheme = ColorManager.lightColorScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: ColorManager.background,
      dividerColor: ColorManager.border,
      fontFamily: 'Tajawal',
      textTheme: _textTheme().apply(
        bodyColor: ColorManager.textPrimary,
        displayColor: ColorManager.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
      ),
    );
  }

  static TextTheme _textTheme() {
    return const TextTheme(
      // Header 1: 32 / Bold / LH 40
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),

      // Header 2: 26 / Bold / LH 32
      headlineMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        height: 32 / 26,
      ),

      // Header 3: 20 / Medium / LH 28
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),

      // Subtitle: 18 / Medium / LH 26
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 26 / 18,
      ),

      // Body: 16 / Regular / LH 26
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 26 / 16,
      ),

      // Button Text: 16 / Bold / LH 20
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),

      // Caption/Small: 12 / Regular / LH 20
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 20 / 12,
      ),
    );
  }
}
