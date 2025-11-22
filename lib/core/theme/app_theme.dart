import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Outfit',
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green),
    useMaterial3: true,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Outfit',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.green,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Colors.black,
    useMaterial3: true,
  );

  // Accent colors per score type
  static Color accentFor(String type) {
    switch (type.toLowerCase()) {
      case 'activity':
        return AppColors.green;
      case 'readiness':
        return AppColors.purple;
      case 'health':
        return AppColors.blue;
      default:
        return AppColors.black;
    }
  }
}
