import 'package:exam_app/core/routes/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:exam_app/core/constants/assets.dart';
import '../../../../core/ui_manager/colors/app_colors.dart';
import '../../../../core/ui_manager/fonts/font_style_manager.dart';
import '../../../../core/ui_manager/fonts/font_sizes_manager.dart';
import '../../../../core/shared/presentation/widgets/app_button.dart';
import '../../domain/entities/exam_entity.dart';

class StartExamScreen extends StatelessWidget {
  const StartExamScreen({super.key, required this.exam});
  final ExamEntity exam;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Start exam',
          style: FontStyleManager.interMedium(
            color: AppColors.blackBase,
            fontSize: FontSizesManager.s20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppImages.assetsImagesProfit,
                  width: 42,
                  height: 47,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    exam.title,
                    style: FontStyleManager.interMedium(
                      color: AppColors.blackBase,
                      fontSize: FontSizesManager.s18,
                    ).copyWith(height: 1.0),
                  ),
                ),
                Text(
                  '${exam.durationMinutes} Minutes',
                  style: FontStyleManager.interRegular(
                    color: AppColors.blueBase,
                    fontSize: FontSizesManager.s14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  exam.level,
                  style: FontStyleManager.interMedium(
                    color: AppColors.blackBase,
                    fontSize: FontSizesManager.s18,
                  ).copyWith(height: 1.0),
                ),
                const SizedBox(width: 8),
                Text(
                  '${exam.questionsCount} Question',
                  style: FontStyleManager.interRegular(
                    color: AppColors.black30,
                    fontSize: FontSizesManager.s14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.blue10, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Instructions',
                    style: FontStyleManager.interMedium(
                      color: AppColors.blackBase,
                      fontSize: FontSizesManager.s18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...[
                    '• Lorem ipsum dolor sit amet consectetur.',
                    '• Lorem ipsum dolor sit amet consectetur.',
                    '• Lorem ipsum dolor sit amet consectetur.',
                  ].map(
                    (i) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        i,
                        style: FontStyleManager.interRegular(
                          color: AppColors.blackBase,
                          fontSize: FontSizesManager.s14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: AppButton(
                title: 'Start',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RoutePath.questions,
                    arguments: exam.id,
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
