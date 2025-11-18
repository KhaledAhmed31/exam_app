import 'package:flutter/material.dart';

import '../../../explore/domain/entities/subject_entity.dart';
import '../widgets/subject_card.dart';
import '../../../../core/ui_manager/fonts/font_style_manager.dart';
import '../../../../core/ui_manager/colors/app_colors.dart';
import '../../../../core/ui_manager/fonts/font_sizes_manager.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  List<SubjectEntity> _mockSubjects() => const [
        SubjectEntity(id: 'sub-1', name: 'Languages', icon: 'https://picsum.photos/seed/languages/80'),
        SubjectEntity(id: 'sub-2', name: 'Science', icon: 'https://picsum.photos/seed/science/80'),
        SubjectEntity(id: 'sub-3', name: 'Mathematics', icon: 'https://picsum.photos/seed/math/80'),
      ];

  @override
  Widget build(BuildContext context) {
    final subjects = _mockSubjects();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore Subjects',
          style: FontStyleManager.interMedium(
            color: AppColors.blackBase,
            fontSize: FontSizesManager.s20,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) => SubjectCard(entity: subjects[index]),
      ),
    );
  }
}