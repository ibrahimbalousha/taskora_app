import 'package:flutter/material.dart';

abstract final class ColorManager {
  // Primary
  static const Color primary500 = Color(0xFF96D2C8);
  static const Color primary300 = Color(0xFFBAE5DE);
  static const Color primary100 = Color(0xFFE3F7F4);

  // Brand secondary (from the dev note palette)
  static const Color brandSecondary = Color(0xFF167F71);

  // Secondary (neutral palette)
  static const Color secondary500 = Color(0xFFB8B1A9);
  static const Color secondary300 = Color(0xFFD6D1CC);
  static const Color secondary100 = Color(0xFFEEECE9);

  // Accent
  static const Color accent = Color(0xFFCBC0DD);
  static const Color accentLight = Color(0xFFF7E1F0);

  // Status / Priority
  static const Color success = Color(0xFFB4E3C1);
  static const Color priorityHigh = Color(0xFFE57373);
  static const Color priorityMedium = Color(0xFFF4C27A);
  static const Color priorityLow = Color(0xFF98C8E0);

  // UI essentials
  static const Color textPrimary = Color(0xFF1D1D1D);
  static const Color border = Color(0xFFE2E2E2);
  static const Color background = Color(0xFFFBFAF9);

  // Common
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Aliases (optional for readability)
  static const Color primary = primary500;
  static const Color secondary = brandSecondary;
  static const Color interactive = secondary100;

  // Light scheme (Material 3)
  static ColorScheme get lightColorScheme => ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: textPrimary,
        secondary: secondary,
        onSecondary: white,
        tertiary: accent,
        onTertiary: textPrimary,
        surface: white,
        onSurface: textPrimary,
        background: background,
        onBackground: textPrimary,
        error: priorityHigh,
        onError: textPrimary,
        outline: border,
      );
}
