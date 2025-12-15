import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/constants/assets.dart';
import 'package:exam_app/core/localization/l10n/app_localizations.dart';
import 'package:exam_app/core/routes/route_path.dart';
import 'package:exam_app/core/shared/presentation/widgets/app_button.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_bloc.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';
import 'package:exam_app/features/results_tap/presentation/bloc/results_history_bloc.dart';
import 'package:exam_app/features/results_tap/presentation/bloc/results_history_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AlertDialogWidget extends StatelessWidget {
  AlertDialogWidget({super.key, required this.bloc});
  final ExamPageBloc bloc;
  final resultsHistoryBloc = getIt<ResultsHistoryBloc>();

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;
    return AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppImages.assetsImagesSandClock),
          Text(
            local.timeOut,
            style: FontStyleManager.robotoRegular(
              fontSize: FontSizesManager.s24,
              color: AppColors.error,
            ),
          ),
        ],
      ),

      actions: [
        AppButton(
          title: local.viewScoreTitle,
          onPressed: () {
              final score = bloc.state.finalScore;

            final examResult = ExamResultsCardEntity(
              duration: bloc
                  .state
                  .getQuestionsState!
                  .data![bloc.state.index]
                  .exam!
                  .duration!
                  .toInt(),
              examId: bloc
                  .state
                  .getQuestionsState!
                  .data![bloc.state.index]
                  .exam!
                  .id
                  .toString(),
              finishDuration: bloc
                  .state
                  .getQuestionsState!
                  .data![bloc.state.index]
                  .exam!
                  .duration!
                  .toInt(),
              numberOfQuestions: bloc.state.getQuestionsState!.totalQuestions,
              subject: bloc
                  .state
                  .getQuestionsState!
                  .data![bloc.state.index]
                  .exam!
                  .title
                  .toString(),
              title: bloc
                  .state
                  .getQuestionsState!
                  .data![bloc.state.index]
                  .exam!
                  .title
                  .toString(),
              score: score
            );
            resultsHistoryBloc.add(SaveExamResultEvent(examResult: examResult));

            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(
              context,
              RoutePath.examScore,
              arguments: {
                "score": score,
                "questions": bloc.state.getQuestionsState?.data,
                "answers": bloc.state.selectedAnswers,
              },
            );
          },
        ),
      ],
    );
  }
}
