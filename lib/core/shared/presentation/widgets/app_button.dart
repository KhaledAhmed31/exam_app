import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.title, this.onPressed});
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48, maxWidth: 343),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.blueBase,overlayColor: AppColors.white),
          onPressed: onPressed,
          child: Text(
            title,
            style: FontStyleManager.robotoMedium(
              fontSize: FontSizesManager.s16,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
