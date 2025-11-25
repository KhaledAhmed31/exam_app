import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/ui_manager/colors/app_colors.dart';
import '../../../../core/ui_manager/fonts/font_sizes_manager.dart';
import '../../../../core/ui_manager/fonts/font_style_manager.dart';
import '../../domain/entities/subject_entity.dart';
import 'package:flutter/material.dart';

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
          //TODO: Navigate to subject screen
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: entity.icon,
            height: 48,
            width: 48,
            fit: BoxFit.cover,
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
