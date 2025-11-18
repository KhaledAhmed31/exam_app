import 'package:exam_app/core/ui_manager/theme/app_theme.dart';
import 'package:exam_app/features/explore/presentation/pages/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/core/routes/route_manager.dart';
import 'package:exam_app/core/routes/route_path.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Exam App",
      theme: AppTheme.light,
      // Force named startup at /home which maps to ExploreScreen.
      initialRoute: RoutePath.home,
      onGenerateRoute: RouteManager.generateRoute,
      // Force ExploreScreen as the app entry for this phase.
      home: const ExploreScreen(),
    );
  }
}
