import '../../../../core/ui_manager/colors/app_colors.dart';
import '../../../../core/ui_manager/fonts/font_sizes_manager.dart';
import '../../../../core/ui_manager/fonts/font_style_manager.dart';
import '../../domain/entities/subject_entity.dart';
import 'package:flutter/material.dart';
import '../../../../core/routes/route_path.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({super.key, required this.entity});
  final SubjectEntity entity;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        onTap: () {
          Navigator.pushNamed(
            context,
            RoutePath.subjectExams,
            arguments: entity,
          );
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            entity.icon,
            height: 48,
            width: 48,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 48,
              width: 48,
              color: AppColors.blue20,
              child: const Icon(Icons.image_not_supported,
                  color: AppColors.blueBase),
            ),
          ),
        ),
        title: Text(
          entity.name,
          style: FontStyleManager.interRegular(
            color: AppColors.blackBase,
            fontSize: FontSizesManager.s16,
          ),
        ),
      ),
    );
  }
}
