import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/localization/l10n/app_localizations.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/explore/domain/entities/subject_entity.dart';
import 'package:exam_app/features/subject%20details/presentation/bloc/subject_details_bloc.dart';
import 'package:exam_app/features/subject%20details/presentation/widgets/exam_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectDetailsScreen extends StatefulWidget {
  const SubjectDetailsScreen({super.key, required this.subject});
  final SubjectEntity subject;

  @override
  State<SubjectDetailsScreen> createState() => _SubjectDetailsScreenState();
}

class _SubjectDetailsScreenState extends State<SubjectDetailsScreen> {
  late AppLocalizations local;

  @override
  Widget build(BuildContext context) {
    local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          highlightColor: Colors.transparent,
          padding: EdgeInsets.only(
            right: local.localeName == 'ar' ? 16 : 0,
            left: local.localeName == 'en' ? 16 : 0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(widget.subject.name),
      ),
      body: BlocProvider.value(
        value: getIt<SubjectDetailsBloc>()
          ..add(GetExamsOnSubjectEvent(widget.subject)),
        child: BlocBuilder<SubjectDetailsBloc, SubjectDetailsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.errorMessage.isNotEmpty) {
              return Center(child: Text(state.errorMessage));
            } else {
              final exams = state.subjectDetails.exams;
              if (exams.isEmpty) {
                return Center(
                  child: Text(
                    'No exams available for this subject',
                    style: FontStyleManager.interMedium(
                      color: AppColors.grey,
                      fontSize: FontSizesManager.s16,
                    ),
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: exams.length,
                itemBuilder: (context, index) {
                  return ExamCard(exam: exams[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
