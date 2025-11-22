import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/features/explore/domain/entities/subject_entity.dart';
import 'package:exam_app/features/subject%20details/presentation/bloc/subject_details_bloc.dart';
import 'package:exam_app/features/exams/domain/entities/exam_entity.dart';
import '../widgets/exam_card.dart';
import '../../../../core/ui_manager/colors/app_colors.dart';
import '../../../../core/ui_manager/fonts/font_style_manager.dart';
import '../../../../core/ui_manager/fonts/font_sizes_manager.dart';

class SubjectExamsScreen extends StatelessWidget {
  const SubjectExamsScreen({super.key, required this.subject});
  final SubjectEntity subject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          subject.name,
          style: FontStyleManager.interMedium(
            color: AppColors.blackBase,
            fontSize: FontSizesManager.s20,
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) =>
            getIt<SubjectDetailsBloc>()..add(GetExamsOnSubjectEvent(subject)),
        child: BlocBuilder<SubjectDetailsBloc, SubjectDetailsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage.isNotEmpty) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: FontStyleManager.interRegular(
                    color: AppColors.grey,
                    fontSize: FontSizesManager.s16,
                  ),
                ),
              );
            }

            final apiExams = state.subjectDetails.exams;

            if (apiExams.isEmpty) {
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

            final exams = apiExams
                .map(
                  (e) => ExamEntity(
                    id: e.id ?? '',
                    title: e.title ?? 'Unknown',
                    duration: e.duration ?? 0,
                    numberOfQuestions: e.numberOfQuestions ?? 0,
                    subject: e.subject,
                    active: e.active,
                  ),
                )
                .toList();

            // Group by title
            final grouped = _groupByTitle(exams);

            return ListView(
              children: grouped.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: Text(
                        entry.key,
                        style: FontStyleManager.interMedium(
                          color: AppColors.blackBase,
                          fontSize: FontSizesManager.s18,
                        ),
                      ),
                    ),
                    ...entry.value.map((e) => ExamCard(exam: e)),
                    const SizedBox(height: 8),
                  ],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  Map<String, List<ExamEntity>> _groupByTitle(List<ExamEntity> items) {
    final Map<String, List<ExamEntity>> grouped = {};
    for (final e in items) {
      grouped.putIfAbsent(e.title, () => []).add(e);
    }
    return grouped;
  }
}
