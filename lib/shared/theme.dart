import 'package:flutter/material.dart';
import 'package:pokedex/shared/colors.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'NotoSans',
    scaffoldBackgroundColor: AppColors.scaffoldBg,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
  );
}
