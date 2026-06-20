import 'package:flutter/material.dart';
import '../color_manager/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    primaryColor: AppColors.primaryColor,
    cardColor: AppColors.whiteColor,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.mainBlack,
    primaryColor: AppColors.secondaryColor,
    cardColor: const Color(0xFF1E1E1E),
  );
}