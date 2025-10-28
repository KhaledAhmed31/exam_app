import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    primaryColor: AppColors.blueBase,
    scaffoldBackgroundColor: AppColors.white,
    textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.blueBase),
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
