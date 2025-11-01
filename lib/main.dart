import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/routes/route_manager.dart';
import 'package:exam_app/core/routes/route_path.dart';
import 'package:exam_app/core/shared/presentation/ui_strings/ui_strings.dart';
import 'package:exam_app/core/ui_manager/theme/app_theme.dart';
import 'package:exam_app/features/auth/login/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  AuthViewModel authViewModel = getIt<AuthViewModel>();
  bool isLoggedIn = await authViewModel.checkIsLoggedIn();
  runApp(MainApp(route: isLoggedIn ? RoutePath.home : RoutePath.login));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, this.route});
  final String? route;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: UiStrings.examApp,
      theme: AppTheme.light,
      onGenerateRoute: RouteManager.generateRoute,
      initialRoute: route,
    );
  }
}
