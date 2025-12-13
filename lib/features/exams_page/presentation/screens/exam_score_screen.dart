import 'package:exam_app/core/constants/spacing.dart';
import 'package:exam_app/core/localization/l10n/app_localizations.dart';
import 'package:exam_app/core/routes/route_path.dart';
import 'package:exam_app/core/shared/presentation/widgets/app_button.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';
import 'package:exam_app/features/exams_page/presentation/widgets/custom_sizedbox.dart';
import 'package:exam_app/features/exams_page/presentation/widgets/score_painter.dart';
import 'package:flutter/material.dart';

class ExamScoreScreen extends StatelessWidget {
  const ExamScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final int score = args["score"];
    final List<QuestionModel> questions = args["questions"];
    final Map<int, String> answers = args["answers"];
    int correct = 0;
    for (int i = 0; i < questions.length; i++) {
      if (answers[i] == questions[i].correct) {
        correct++;
      }
    }
    final int total = questions.length;
    final int incorrect = total - correct;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          local.examScoreTitle,
          style: FontStyleManager.interMedium(
            color: AppColors.blackBase,
            fontSize: FontSizesManager.s20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacementNamed(context, RoutePath.home);
          },
        ),
        iconTheme: IconThemeData(color: AppColors.blackBase),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              local.yourScore,
              style: FontStyleManager.interMedium(
                fontSize: FontSizesManager.s18,
                color: AppColors.blackBase,
              ),
            ),
            const SizedBox(height: Spacing.sp28),
            Row(
              children: [
                Center(
                  child: SizedBox(
                    height: 135,
                    width: 135,
                    child: CustomPaint(
                      painter: ScorePainter(
                        score: score / 100,
                        scoreColor: AppColors.blueBase,
                        remainColor: AppColors.error,
                      ),
                      child: Center(
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "$score%",
                            style: FontStyleManager.interMedium(
                              fontSize: FontSizesManager.s20,
                              color: AppColors.blackBase,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Spacing.sp28),
                Column(
                  children: [
                    CustomSizedbox(
                      color: AppColors.blueBase,
                      text: local.correct,
                      numOfQuestions: correct,
                    ),
                    CustomSizedbox(
                      color: AppColors.error,
                      text: local.incorrect,
                      numOfQuestions: incorrect,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: Spacing.sp80),
            AppButton(
              title: local.showResults,
              isDisabled: false,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RoutePath.examResults,
                  arguments: {"questions": questions, "answers": answers},
                );
              },
            ),
            const SizedBox(height: Spacing.sp24),
            SizedBox(
              height: 48,
              width: 343,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.blueBase, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, RoutePath.examPage);
                },
                child: Text(
                  "Start again",
                  style: FontStyleManager.robotoMedium(
                    fontSize: FontSizesManager.s16,
                    color: AppColors.blueBase,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
