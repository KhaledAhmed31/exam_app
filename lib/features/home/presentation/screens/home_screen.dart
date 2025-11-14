import 'package:exam_app/core/constants/app_icons.dart';
import 'package:exam_app/core/localization/l10n/app_localizations.dart';
import 'package:exam_app/features/explore/presentation/pages/explore_screen.dart';
import 'package:exam_app/features/home/presentation/screens/profile_screen.dart';
import 'package:exam_app/features/home/presentation/screens/result_screen.dart';
import 'package:exam_app/features/home/presentation/widgets/custom_nav_bar.dart';
import 'package:exam_app/features/home/presentation/widgets/nav_bar_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int selectedIndex = 0;
  final List<Widget> tabs =const [ExploreScreen(), ResultScreen(), ProfileScreen()];
  @override
  void initState() {
    _pageController = PageController(initialPage: selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations local = AppLocalizations.of(context)!;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) => setState(() => selectedIndex = value),
        children: tabs,
      ),

      bottomNavigationBar: CustomNavBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          _pageController.animateToPage(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
            value,
          );
        },
        items: [
          NavBarItem(
            icon: AppIcons.assetsIconsHome,
            label: local.exploreTabLabel,
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
