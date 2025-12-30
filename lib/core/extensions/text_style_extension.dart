import 'package:flutter/material.dart';

extension AppTextStyleX on TextTheme {
  TextStyle get _baseSmall => bodySmall ?? const TextStyle(fontSize: 12);

  TextStyle get fieldLabel => _baseSmall.copyWith(
        fontWeight: FontWeight.w600,
      );

  TextStyle fieldError(Color color) => _baseSmall.copyWith(
        color: color,
        fontWeight: FontWeight.w500,
      );
}
