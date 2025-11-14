import 'package:exam_app/core/constants/app_icons.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 48,
        child: TextField(
          hintLocales: [Locale('en', 'US')],
          cursorColor: AppColors.blueBase,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(maxWidth: 40, maxHeight: 24),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SvgPicture.asset(
                AppIcons.assetsIconsSearch,
                colorFilter: ColorFilter.mode(
                  AppColors.black30,
                  BlendMode.srcIn,
                ),
              ),
            ),
            hint: Text(
              "Search",
              style: FontStyleManager.interMedium(
                color: AppColors.black30,
                fontSize: 14,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: AppColors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: AppColors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
