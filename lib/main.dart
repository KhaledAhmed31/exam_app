import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/routes/route_manager.dart';
import 'package:exam_app/core/routes/route_path.dart';
import 'package:exam_app/core/ui_manager/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteManager.generateRoute,
      title: "Exam App",
      theme: AppTheme.light,
      initialRoute: RoutePath.forgetPassword,
    );
  }
}
