import 'package:flutter/material.dart';

import '../../../explore/domain/entities/subject_entity.dart';
import '../../data/mock/mock_exams.dart';
import '../../domain/entities/exam_entity.dart';
import '../widgets/exam_card.dart';
import '../../../../core/ui_manager/colors/app_colors.dart';
import '../../../../core/ui_manager/fonts/font_style_manager.dart';
import '../../../../core/ui_manager/fonts/font_sizes_manager.dart';

class SubjectExamsScreen extends StatefulWidget {
  const SubjectExamsScreen({super.key, required this.subject});
  final SubjectEntity subject;

  @override
  State<SubjectExamsScreen> createState() => _SubjectExamsScreenState();
}

class _SubjectExamsScreenState extends State<SubjectExamsScreen> {
  late List<ExamEntity> exams;

  @override
  void initState() {
    super.initState();
    exams = mockExamsForSubject(widget.subject.id);
  }

  Map<String, List<ExamEntity>> _groupByTitle(List<ExamEntity> items) {
    final Map<String, List<ExamEntity>> grouped = {};
    for (final e in items) {
      grouped.putIfAbsent(e.title, () => []).add(e);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByTitle(exams);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.subject.name,
          style: FontStyleManager.interMedium(
            color: AppColors.blackBase,
            fontSize: FontSizesManager.s20,
          ),
        ),
      ),
      body: ListView(
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
      ),
    );
  }
}
