import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_bloc.dart';
import 'package:exam_app/features/exams_page/presentation/widgets/alert_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class TimerAppBar extends StatefulWidget {
  const TimerAppBar({super.key});

  @override
  State<TimerAppBar> createState() => TimerAppBarState();
}

class TimerAppBarState extends State<TimerAppBar> {
  Color timerColor = AppColors.success;
  late DateTime endTime;

  @override
  void initState() {
    super.initState();
    final state = BlocProvider.of<ExamPageBloc>(context).state;
    final int? time =
        state.getQuestionsState?.data?[state.index].exam?.duration;
    endTime = DateTime.now().add(Duration(minutes: time ?? 30));
  }

  @override
  Widget build(BuildContext context) {
    return TimerCountdown(
      enableDescriptions: false,
      endTime: endTime,
      format: CountDownTimerFormat.minutesSeconds,
      colonsTextStyle: FontStyleManager.interMedium(
        color: timerColor,
        fontSize: FontSizesManager.s20,
      ),
      spacerWidth: 0,
      timeTextStyle: FontStyleManager.interMedium(
        color: timerColor,
        fontSize: FontSizesManager.s20,
      ),
      onEnd: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialogWidget();
          },
        );
      },
      onTick: (remainingTime) {
        if (remainingTime.inMinutes <= 10) {
          setState(() {
            timerColor = AppColors.error;
          });
        }
      },
    );
  }
}
