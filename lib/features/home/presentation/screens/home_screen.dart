import 'package:exam_app/core/constants/app_icons.dart';
import 'package:exam_app/core/localization/l10n/app_localizations.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/home/presentation/screens/explore_screen.dart';
import 'package:exam_app/features/home/presentation/screens/profile_screen.dart';
import 'package:exam_app/features/home/presentation/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [ExploreScreen(), ResultScreen(), ProfileScreen()];

  Widget _buildIcon(int index) {
    return selectedIndex == index
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.blue10,
            ),
            child: SvgPicture.asset(
              AppIcons.assetsIconsHome,
              colorFilter: ColorFilter.mode(
                AppColors.blueBase,
                BlendMode.srcIn,
              ),
            ),
          )
        : SvgPicture.asset(
            AppIcons.assetsIconsHome,
            colorFilter: ColorFilter.mode(AppColors.black30, BlendMode.srcIn),
          );
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          (selectedIndex == 0
              ? local.exploreTabLabel
              : selectedIndex == 1
              ? local.resultTabLabel
              : local.profileTabLabel),
          style: FontStyleManager.interMedium(
            color: AppColors.blackBase,
            fontSize: FontSizesManager.s20,
          ),
        ),

        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: AppColors.black10),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: _buildIcon(0),
              label: local.exploreTabLabel,
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(1),
              label: local.resultTabLabel,
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(2),
              label: local.profileTabLabel,
            ),
          ],
        ),
      ),
      body: tabs[selectedIndex],
    );
  }
}
