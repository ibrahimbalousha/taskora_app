import 'package:flutter/material.dart';

class AppSizes {
  // Base grid
  static const double grid = 4;

  // Spacing (padding/margin/gap)
  static const double s2 = 8;
  static const double s3 = 12;
  static const double s4 = 16;
  static const double s5 = 20;
  static const double s6 = 24;
  static const double s8 = 32;
  static const double s10 = 40;
  static const double s12 = 48;

  //font Size
  static const double fz2 = 12;
  static const double fz3 = 16;
  static const double fz4 = 18;

  // Border radius
  static const double r8 = 8;
  static const double r12 = 12;
  static const double r16 = 16;
  static const double r24 = 24;

  // Text button sized
  static const double customTextButtonSized = 12;
  static const double textButtonSized = 16;

  // Icon sizes
  static const double i16 = 16;
  static const double i20 = 20;
  static const double i24 = 24;
  static const double i28 = 28;
  static const double i32 = 32;

  // Control heights
  static const double hButton = 48;
  static const double hInput = 52;
  static const double hAppBar = 56;

  // Layout constraints
  static const double maxContentWidth = 560; // للموبايل/تابلت إن لزم
}

class AppPadding {
  static const EdgeInsets topPagePadding = EdgeInsets.only(top: 16);
  static const EdgeInsets topTextFieldPadding = EdgeInsets.only(top: 16);
  static const EdgeInsets elevatedButtonPadding = EdgeInsets.only(
    top: 24,
    bottom: 8,
  );

  static const EdgeInsets horizontalPagePadding = EdgeInsets.symmetric(
    horizontal: 20,
  );
}
