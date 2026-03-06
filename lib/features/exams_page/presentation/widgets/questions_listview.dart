// ignore_for_file: deprecated_member_use

import 'package:exam_app/core/constants/spacing.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_bloc.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsListview extends StatefulWidget {
  const QuestionsListview({super.key});

  @override
  State<QuestionsListview> createState() => _QuestionsListviewState();
}

class _QuestionsListviewState extends State<QuestionsListview> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ExamPageBloc>(context);
    final state = bloc.state;
    final index = state.index;
    final answers = state.getQuestionsState?.data?[index].answers;

    return Expanded(
      flex: 3,
      child: ListView.builder(
        itemCount: answers?.length,
        itemBuilder: (context, answerIndex) {
          final selectedAnswerIndex = state.selectedAnswers[index];
          final isSelected = selectedAnswerIndex == answerIndex.toString();
          final answerKey = answers?[answerIndex].key;

          return Container(
            padding: EdgeInsets.symmetric(
              vertical: Spacing.verticalPadding,
              horizontal: Spacing.horizontalPadding,
            ),
            margin: EdgeInsets.all(Spacing.sp16),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.blue10 : AppColors.lightBlue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Radio<String>(
                  value: answerKey!,
                  groupValue: state.selectedAnswers[index],
                  onChanged: (value) {
                    bloc.add(SelectAnswer(index, value!));
                    setState(() {});
                  },
                ),
                Flexible(
                  child: Text(
                    '${answers?[answerIndex].answer}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: FontStyleManager.interRegular(
                      color: isSelected
                          ? AppColors.blue90
                          : AppColors.blackBase,
                      fontSize: FontSizesManager.s14,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
