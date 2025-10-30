import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:flutter/material.dart';

class VerifyCodeTab extends StatefulWidget {
  const VerifyCodeTab({super.key});

  @override
  State<VerifyCodeTab> createState() => _VerifyCodeTabState();
}

class _VerifyCodeTabState extends State<VerifyCodeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Enter Code",
          style: FontStyleManager.interMedium(
            color: AppColors.blackBase,
            fontSize: FontSizesManager.s20,
          ),
        ),
      ],
    );
  }
}
