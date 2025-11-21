import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/shared/presentation/widgets/app_button.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_bloc.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_events.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_states.dart';
import 'package:exam_app/features/exams_page/presentation/widgets/alert_dialog_widget.dart';
import 'package:exam_app/features/exams_page/presentation/widgets/linear_percent_indicator_widget.dart';
import 'package:exam_app/features/exams_page/presentation/widgets/questions_listview.dart';
import 'package:exam_app/features/exams_page/presentation/widgets/timer_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/core/localization/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamPageScreen extends StatefulWidget {
  const ExamPageScreen({super.key});

  @override
  State<ExamPageScreen> createState() => _ExamPageScreenState();
}

class _ExamPageScreenState extends State<ExamPageScreen> {
  final ExamPageBloc examPageBloc = getIt<ExamPageBloc>();
  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;
    return BlocProvider<ExamPageBloc>(
      create: (context) =>
          examPageBloc
            ..add(GetExamQuestionsEvent(examId: '670070a830a3c3c1944a9c63')),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          title: BlocBuilder<ExamPageBloc, ExamPageStates>(
            builder: (context, state) {
              if (state.getQuestionsState?.data?[state.index].exam?.title ==
                  null) {
                return const Text('');
              }
              return Text(
                '${state.getQuestionsState?.data?[state.index].exam?.title}',
                style: FontStyleManager.interMedium(
                  color: AppColors.blackBase,
                  fontSize: FontSizesManager.s20,
                ),
              );
            },
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  Image.asset("assets/images/alarm_pic.png"),
                  SizedBox(width: 8),
                  BlocBuilder<ExamPageBloc, ExamPageStates>(
                    builder: (context, state) {
                      if (state.getQuestionsState == null ||
                          state.getQuestionsState!.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.blueBase,
                          ),
                        );
                      }
                      return TimerAppBar();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        body: BlocBuilder<ExamPageBloc, ExamPageStates>(
          builder: (context, state) {
            int? totalQuestions = state.getQuestionsState?.data?.length;
            // ignore: avoid_print
            print(
              '<<<<<<< current ${state.currentQuestion} total $totalQuestions index ${state.index} ',
            );
            if (state.getQuestionsState?.data == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      '${local.questionText} ${state.currentQuestion} ${local.ofText} ${state.getQuestionsState?.data?.length}',
                      style: FontStyleManager.robotoMedium(
                        fontSize: FontSizesManager.s14,
                        color: AppColors.gray,
                      ),
                    ),
                  ),
                  SizedBox(height: 3),
                  LinearPercentIndicatorWidget(),
                  SizedBox(height: 28),
                  Text(
                    local.selectCorrectAnswer,
                    style: FontStyleManager.interMedium(
                      color: AppColors.blackBase,
                      fontSize: FontSizesManager.s18,
                    ),
                  ),
                  SizedBox(height: 30),

                  Text(
                    '${state.getQuestionsState?.data?[state.index].question}',
                    style: FontStyleManager.interMedium(
                      color: AppColors.blackBase,
                      fontSize: FontSizesManager.s18,
                    ),
                  ),
                  QuestionsListview(),

                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            title: local.back,
                            isDisabled: state.currentQuestion == 1,
                            onPressed: () {
                              examPageBloc.add(PreviousQuestionEvent());
                            },
                          ),
                        ),

                        SizedBox(width: 16),

                        Expanded(
                          child: AppButton(
                            title: state.currentQuestion != totalQuestions
                                ? local.next
                                : local.finish,
                            onPressed: () {
                              state.currentQuestion != totalQuestions
                                  ? examPageBloc.add(NextQuestionEvent())
                                  : showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return AlertDialogWidget();
                                      },
                                    );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
