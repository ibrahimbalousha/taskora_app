import 'package:flutter/material.dart';

import '../config/constants/color_manager.dart';
class LightTheme {
  LightTheme._();

  static ThemeData get theme {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: ColorManager.primary,
      onPrimary: Colors.white,
      secondary: ColorManager.primarySoft,
      onSecondary: ColorManager.textPrimary,
      error: ColorManager.error,
      onError: Colors.white,
      background: ColorManager.backgroundLight,
      onBackground: ColorManager.textPrimary,
      surface: Colors.white,
      onSurface: ColorManager.textPrimary,
    );

    final base = ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: ColorManager.backgroundLight,
      fontFamily: 'Tajawal',
    );

    final textTheme = base.textTheme.apply(
      bodyColor: ColorManager.textPrimary,
      displayColor: ColorManager.textPrimary,
      fontFamily: 'Tajawal',
    );

    return base.copyWith(
      textTheme: textTheme.copyWith(
        headlineLarge: textTheme.headlineLarge?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          height: 30 / 18,
        ),
        headlineMedium: textTheme.headlineMedium?.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          height: 30 / 15,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ColorManager.textSecondary,
        ),
        labelLarge: textTheme.labelLarge?.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: ColorManager.backgroundLight,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: ColorManager.textPrimary),
        titleTextStyle: TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: ColorManager.textPrimary,
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: ColorManager.borderLight,
        thickness: 1,
      ),

      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: ColorManager.borderLight),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        hintStyle: const TextStyle(
          fontFamily: 'Tajawal',
          color: ColorManager.textSecondary,
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        labelStyle: const TextStyle(
          fontFamily: 'Tajawal',
          color: ColorManager.textSecondary,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: ColorManager.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: ColorManager.primary, width: 1.2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: ColorManager.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: ColorManager.error, width: 1.2),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: ColorManager.borderLight,
          disabledForegroundColor: ColorManager.textSecondary,
          elevation: 0,
          textStyle: const TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          minimumSize: const Size(double.infinity, 48),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorManager.primary,
          textStyle: const TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorManager.primary,
          side: const BorderSide(color: ColorManager.borderLight),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          minimumSize: const Size(double.infinity, 48),
          textStyle: const TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: ColorManager.textPrimary,
        contentTextStyle: const TextStyle(
          fontFamily: 'Tajawal',
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
