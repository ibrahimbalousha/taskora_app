import 'package:flutter/material.dart';

class ColorManager {
  ColorManager._();

  // Primary palette
  static const Color primary = Color(0xFF5B6CFF); 
  static const Color primarySoft = Color(0xFFEFF1FF); 
  static const Color primaryHover = Color(0xFFC7D2FE); 

  // Neutral palette
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color textPrimary = Color(0xFF1A2C62);
  static const Color textSecondary = Color(0xFF64748B);

  // Status / semantic colors
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFFB923C);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF6380D7);

  // Priority aliases (from design)
  static const Color priorityHigh = error;
  static const Color priorityMedium = warning;
  static const Color priorityLow = info;
}
