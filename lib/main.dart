import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/routes/route_manager.dart';
import 'package:exam_app/core/routes/route_path.dart';
import 'package:exam_app/core/shared/presentation/ui_%5Dstrings/ui_strings.dart';
import 'package:exam_app/core/ui_manager/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: UiStrings.examApp,
      theme: AppTheme.light,
      onGenerateRoute: RouteManager.generateRoute,
      initialRoute: RoutePath.login,
    );
  }
}
