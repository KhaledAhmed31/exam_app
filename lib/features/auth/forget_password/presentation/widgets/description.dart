import 'package:flutter/material.dart';

import '../../../../../core/ui_manager/colors/app_colors.dart';
import '../../../../../core/ui_manager/fonts/font_sizes_manager.dart';
import '../../../../../core/ui_manager/fonts/font_style_manager.dart';

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.title,
    required this.description,
  });
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: FontStyleManager.interMedium(
            fontSize: FontSizesManager.s18,
            color: AppColors.blackBase,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 285),
          child: Text(
            description,
            style: FontStyleManager.interRegular(
              fontSize: FontSizesManager.s14,
              color: AppColors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
