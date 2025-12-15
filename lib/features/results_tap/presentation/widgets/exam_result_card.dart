import 'package:exam_app/core/constants/assets.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';
import 'package:flutter/material.dart';

class ExamResultCard extends StatelessWidget {
  const ExamResultCard({super.key, required this.exam});
  final ExamResultsCardEntity exam;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
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
              child: SizedBox(
                height: 68,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exam.title,
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
                    const Spacer(),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${exam.score.toString()}%',
                            style: FontStyleManager.interBold(
                              color: AppColors.blueBase,
                              fontSize: FontSizesManager.s13,
                            ),
                          ),
                          TextSpan(
                            text: ' correct answers in ',
                            style: FontStyleManager.interRegular(
                              color: AppColors.blueBase,
                              fontSize: FontSizesManager.s13,
                            ),
                          ),
                          TextSpan(
                            text: '${exam.finishDuration}',
                            style: FontStyleManager.interBold(
                              color: AppColors.blueBase,
                              fontSize: FontSizesManager.s13,
                            ),
                          ),
                          TextSpan(
                            text: ' min',
                            style: FontStyleManager.interRegular(
                              color: AppColors.blueBase,
                              fontSize: FontSizesManager.s13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${exam.duration} Minutes',
                  style: FontStyleManager.interRegular(
                    color: AppColors.blackBase,
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
