import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final String assetPath;

  const AppLogo({
    super.key,
    this.size = 72,
    this.assetPath = 'assets/images/logo.png',
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
