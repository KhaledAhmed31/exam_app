import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_bloc.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LinearPercentIndicatorWidget extends StatelessWidget {
  const LinearPercentIndicatorWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamPageBloc, ExamPageStates>(
      builder: (context, state) {
        double progress = 0.0;

        if (state.getQuestionsState?.data != null &&
            state.getQuestionsState!.data!.isNotEmpty) {
          var numberOfQuestions = state.getQuestionsState?.data?.length;
          if (numberOfQuestions != 0) {
            progress = state.currentQuestion / numberOfQuestions!.toDouble();
          }
        }
        return LinearPercentIndicator(
          padding: EdgeInsets.symmetric(horizontal: 16),
          lineHeight: 4.0,
          percent: progress,
          backgroundColor: AppColors.black10,
          progressColor: AppColors.blueBase,
        );
      },
    );
  }
}
