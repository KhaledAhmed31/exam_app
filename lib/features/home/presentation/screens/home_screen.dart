import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../explore/presentation/pages/explore_screen.dart';
import 'profile_screen.dart';
import 'result_screen.dart';
import '../widgets/nav_bar_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late AppLocalizations local;
  int selectedIndex = 0;
  final List<Widget> tabs = const [
    ExploreScreen(),
    ResultScreen(),
    ProfileScreen(),
  ];
  @override
  void initState() {
    _pageController = PageController(initialPage: selectedIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.lightBlue,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.lightBlue,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    local = AppLocalizations.of(context)!;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => setState(() => selectedIndex = value),
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          _pageController.animateToPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            value,
          );
        },
        items: [
          NavBarItem(
            icon: AppIcons.assetsIconsHome,
            label: local.exploreNavigationTitle,
          ),
          NavBarItem(
            icon: AppIcons.assetsIconsCarbonResultDraft,
            label: local.resultTabLabel,
          ),
          NavBarItem(
            icon: AppIcons.assetsIconsPerson,
            label: local.profileTabLabel,
          ),
        ],
      ),
    );
  }
}
