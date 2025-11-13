// ignore_for_file: avoid_print, deprecated_member_use

import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsListview extends StatefulWidget {
  const QuestionsListview({super.key});

  @override
  State<QuestionsListview> createState() => _QuestionsListviewState();
}

class _QuestionsListviewState extends State<QuestionsListview> {


  
  int? selectedValue;
  @override
  Widget build(BuildContext context) {
    final index = BlocProvider.of<ExamPageBloc>(context).state.index;
    final answers = BlocProvider.of<ExamPageBloc>(context,).state.getQuestionsState?.data?[index.toInt()].answers;
    if (answers == null || answers.isEmpty) {
      return Center(child: Text('No answers available'));
    }
    return Expanded(
      flex: 2,
      child: ListView.builder(
        itemCount: answers.length,
        itemBuilder: (context, index) {
          print('<<<<<<< index $index');
          final isSelected = selectedValue == index;
          return Container(
            padding: EdgeInsets.symmetric(vertical: 17.5, horizontal: 12),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.blue10 : AppColors.lightBlue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Radio(
                  autofocus: false,
                  value: index,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
                Text(
                  '${answers[index].answer}',
                  style: FontStyleManager.interRegular(
                    color: isSelected ? AppColors.blue90 : AppColors.blackBase,
                    fontSize: FontSizesManager.s14,
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
