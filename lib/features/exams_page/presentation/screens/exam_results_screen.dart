import 'package:exam_app/core/constants/spacing.dart';
import 'package:exam_app/core/localization/l10n/app_localizations.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';

class ExamResultsScreen extends StatelessWidget {
  const ExamResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final List<QuestionModel> questions = args["questions"];
    final Map<int, String> answers = args["answers"];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          local.answersTitle,
          style: FontStyleManager.interMedium(
            color: AppColors.blackBase,
            fontSize: FontSizesManager.s20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(Spacing.sp16),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final q = questions[index];
          final userAnswer = answers[index];
          final correctAnswer = q.correct;

          return Container(
            margin: const EdgeInsets.only(bottom: Spacing.sp20),
            padding: const EdgeInsets.all(Spacing.sp16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  spreadRadius: 1,
                  color: AppColors.black10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  q.question ?? "",
                  style: FontStyleManager.interMedium(
                    color: AppColors.black,
                    fontSize: FontSizesManager.s18,
                  ),
                ),
                const SizedBox(height: Spacing.sp16),
                Column(
                  children: q.answers!.map((a) {
                    final isCorrect = a.key == correctAnswer;
                    final isUserSelected = a.key == userAnswer;
                    Color bgColor = AppColors.lightBlue; // default grey
                    Icon? icon;

                    if (isCorrect) {
                      bgColor = AppColors.lightGreen; // green
                      icon = const Icon(
                        Icons.check_circle,
                        color: AppColors.success,
                        size: 20,
                      );
                    }

                    if (isUserSelected && !isCorrect) {
                      bgColor = AppColors.lightRed; // red
                      icon = const Icon(
                        Icons.cancel,
                        color: AppColors.error,
                        size: 20,
                      );
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: Spacing.sp8),
                      padding: const EdgeInsets.all(Spacing.sp12),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          icon ??
                              const Icon(
                                Icons.radio_button_unchecked,
                                size: 20,
                                color: Colors.black45,
                              ),
                          const SizedBox(width: Spacing.sp12),
                          Expanded(
                            child: Text(
                              a.answer ?? "",
                              style: FontStyleManager.interRegular(
                                color: AppColors.black,
                                fontSize: FontSizesManager.s14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
