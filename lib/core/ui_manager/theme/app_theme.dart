import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../fonts/font_sizes_manager.dart';
import '../fonts/font_style_manager.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    primaryColor: AppColors.blueBase,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.blueBase,
      surface: AppColors.blue20,onSurface: AppColors.white
    ),
    canvasColor: AppColors.blueBase,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.white,
      elevation: 0,
      titleSpacing: 0,
      leadingWidth: 44,
      titleTextStyle: FontStyleManager.interMedium(
        color: AppColors.blackBase,
        fontSize: FontSizesManager.s20,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.blueBase,
      selectionHandleColor: AppColors.blueBase,
    ),
    textTheme: TextTheme(
      bodyLarge: FontStyleManager.robotoRegular(
        color: AppColors.placholder,
        fontSize: FontSizesManager.s14,
      ),
      bodySmall: FontStyleManager.robotoRegular(
        color: AppColors.gray,
        fontSize: FontSizesManager.s12,
      ),
    ),
  );
}
