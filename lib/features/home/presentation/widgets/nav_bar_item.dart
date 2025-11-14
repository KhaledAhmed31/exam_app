import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class NavBarItem extends BottomNavigationBarItem {
   NavBarItem({required super.label, required String icon})
    : super(
        icon: SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(AppColors.blueBase, BlendMode.srcIn),
        ),
        activeIcon: Container(
          height: 32,
          width: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.blue10,
          ),
          child: SvgPicture.asset(
            fit: BoxFit.scaleDown,
            icon,
            colorFilter: ColorFilter.mode(AppColors.blueBase, BlendMode.srcIn),
          ),
        ),
      );
}