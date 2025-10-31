import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ResendCodeSection extends StatelessWidget {
  const ResendCodeSection({
    super.key,
    required this.message,
    required this.buttonTitle,
    this.onTap,
  });
  final String message;
  final String buttonTitle;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: message,
            style: FontStyleManager.interRegular(
              color: AppColors.blackBase,
              fontSize: FontSizesManager.s16,
            ),
          ),
          TextSpan(
            text: buttonTitle,
            recognizer: TapGestureRecognizer()..onTap = onTap,
            style: FontStyleManager.interRegular(
              color: AppColors.blueBase,
              fontSize: FontSizesManager.s16,
            ).copyWith(decoration: TextDecoration.underline),
          ),
        ],
      ),
    );
  }
}
