import 'package:exam_app/core/constants/spacing.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:flutter/material.dart';

class CustomSizedbox extends StatelessWidget {
  const CustomSizedbox({
    super.key,
    required this.color,
    required this.text,
    required this.numOfQuestions,
  });
  final Color color;
  final String text;
  final int numOfQuestions;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: FontStyleManager.interMedium(
              fontSize: FontSizesManager.s16,
              color: color,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(Spacing.sp5),
            padding: const EdgeInsets.all(Spacing.sp8),
            decoration: BoxDecoration(
              border: Border.all(color: color),
              shape: BoxShape.circle,
            ),
            child: Text(
              numOfQuestions.toString(),
              style: FontStyleManager.interMedium(
                fontSize: FontSizesManager.s14,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
