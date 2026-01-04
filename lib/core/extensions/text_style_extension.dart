import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle? {
  TextStyle copy({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    TextDecoration? decoration,
    double? letterSpacing,
  }) {
    final base = this ?? const TextStyle();
    return base.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      decoration: decoration,
      letterSpacing: letterSpacing,
    );
  }
}

extension TextThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle? get h1 => textTheme.headlineLarge;
  TextStyle? get h2 => textTheme.headlineMedium;
  TextStyle? get h3 => textTheme.headlineSmall;
  TextStyle? get h4 => textTheme.titleLarge;

  TextStyle? get bodyL => textTheme.bodyLarge;
  TextStyle? get bodyM => textTheme.bodyMedium;
  TextStyle? get bodyS => textTheme.bodySmall;

  TextStyle? get labelL => textTheme.labelLarge;
  TextStyle? get labelM => textTheme.labelMedium;
  TextStyle? get labelS => textTheme.labelSmall;
}
