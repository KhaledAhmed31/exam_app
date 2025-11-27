import 'package:exam_app/core/constants/assets.dart';
import 'package:exam_app/core/localization/l10n/app_localizations.dart';
import 'package:exam_app/core/routes/route_path.dart';
import 'package:exam_app/core/shared/presentation/widgets/app_button.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({super.key, required this.bloc});
  final ExamPageBloc bloc;
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
