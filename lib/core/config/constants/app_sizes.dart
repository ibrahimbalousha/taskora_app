import 'package:flutter/widgets.dart';

abstract final class AppSpacing {
  // 4-pt grid spacing tokens
  static const double x1 = 4;
  static const double x2 = 8;
  static const double x3 = 12;
  static const double x4 = 16; // main mobile padding
  static const double x5 = 20;
  static const double x6 = 24;
  static const double x7 = 28;
  static const double x8 = 32;
  static const double x9 = 36;
  static const double x10 = 40;
  static const double x11 = 44;
  static const double x12 = 48;
  static const double x13 = 52;
  static const double x14 = 56;
  static const double x15 = 60;
  static const double x16 = 64;
  static const double x17 = 68;
  static const double x18 = 72;
  static const double x19 = 76;
  static const double x20 = 80;
}

abstract final class AppRadius {
  // Replace if you have official radius tokens in Figma
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
}

abstract final class AppInsets {
  static const EdgeInsets screenPadding =
      EdgeInsets.symmetric(horizontal: AppSpacing.x4, vertical: AppSpacing.x4);
}

abstract final class AppGrid {
  // Breakpoints (from Figma)
  static const double mobileMax = 480; // less than 480px
  static const double tabletMin = 481; // from 481px
  static const double tabletMax = 1024; // to 1024px
  static const double desktopMin = 1025; // more than 1024px

  // Mobile grid (from Figma)
  static const int mobileColumns = 4;
  static const double mobileMargin = 16;
  static const double mobileGutter = 16;

  // Tablet grid (from Figma)
  static const int tabletColumns = 8;
  static const double tabletMargin = 32;
  static const double tabletGutter = 16;

  // Desktop grid (from Figma)
  static const int desktopColumns = 12;
  static const double desktopGutter = 24;
  static const double desktopMaxWidth = 1120;
}
