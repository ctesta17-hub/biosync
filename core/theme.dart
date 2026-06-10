import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xFFE8440A);
  static const background = Color(0xFFF5F4F0);
  static const surface = Colors.white;
  static const dark = Color(0xFF1A1A1A);
  static const textMuted = Color(0xFFAAAAAA);
  static const textSecondary = Color(0xFF888888);
  static const divider = Color(0xFFEEEEEE);
  static const primaryLight = Color(0xFFFFF3EF);
  static const blue = Color(0xFF2979C9);
  static const blueLight = Color(0xFFE6F4FF);
  static const gold = Color(0xFFE8C87A);
}

ThemeData buildAppTheme() {
  return ThemeData(
    fontFamily: 'Nunito',
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
  );
}
