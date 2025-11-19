import 'package:exam_app/core/constants/assets.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/subject%20details/domain/entities/exam_entity.dart';
import 'package:flutter/material.dart';

class ExamCard extends StatelessWidget {
  const ExamCard({super.key, required this.exam});
  final ExamEntity exam;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.assetsImagesProfit,
              fit: BoxFit.contain,
              height: 71,
              width: 60,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exam.title ?? 'No Title',
                    style: FontStyleManager.interMedium(
                      color: AppColors.blackBase,
                      fontSize: FontSizesManager.s16,
                    ),
                  ),
                  Text(
                    '${exam.numberOfQuestions} questions',
                    style: FontStyleManager.interRegular(
                      color: AppColors.grey,
                      fontSize: FontSizesManager.s13,
                    ),
                  ),
                ],
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${exam.duration} Minutes',
                  style: FontStyleManager.interRegular(
                    color: AppColors.blueBase,
                    fontSize: FontSizesManager.s13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
