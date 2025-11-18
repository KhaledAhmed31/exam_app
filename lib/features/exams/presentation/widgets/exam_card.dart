import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:exam_app/core/constants/assets.dart';

import '../../../../core/ui_manager/colors/app_colors.dart';
import '../../../../core/ui_manager/fonts/font_sizes_manager.dart';
import '../../../../core/ui_manager/fonts/font_style_manager.dart';
import '../../../../core/routes/route_path.dart';
import '../../domain/entities/exam_entity.dart';

class ExamCard extends StatelessWidget {
  const ExamCard({super.key, required this.exam});
  final ExamEntity exam;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(
            context,
            RoutePath.startExam,
            arguments: {'examId': exam.id, 'exam': exam},
          );
        },
        leading: SizedBox(
          width: 60,
          height: 71,
          child: SvgPicture.asset(
            AppImages.assetsImagesProfit,
            width: 60,
            height: 71,
          ),
        ),
        title: Text(
          exam.level,
          style: FontStyleManager.interMedium(
            color: AppColors.blackBase,
            fontSize: FontSizesManager.s18,
          ).copyWith(height: 1.0),
        ),
        trailing: Text(
          '${exam.durationMinutes} Minutes',
          style: FontStyleManager.interRegular(
            color: AppColors.blueBase,
            fontSize: FontSizesManager.s14,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${exam.questionsCount} Question',
              style: FontStyleManager.interRegular(
                color: AppColors.black30,
                fontSize: FontSizesManager.s12,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'From: ${exam.minScore.toStringAsFixed(2)}',
                  style: FontStyleManager.interRegular(
                    color: AppColors.blackBase,
                    fontSize: FontSizesManager.s12,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'To: ${exam.maxScore.toStringAsFixed(2)}',
                  style: FontStyleManager.interRegular(
                    color: AppColors.blackBase,
                    fontSize: FontSizesManager.s12,
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
