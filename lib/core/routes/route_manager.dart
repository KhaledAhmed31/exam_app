import 'package:exam_app/core/routes/route_path.dart';
import 'package:exam_app/features/signup/presentation/screens/signup_screen.dart';
import 'package:exam_app/features/home/presentation/screens/home_screen.dart';
import 'package:exam_app/features/auth/login/presentation/screens/login_screen.dart';
import '../../features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
          settings: settings,
        );
      case RoutePath.login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
          settings: settings,
        );
      case RoutePath.signup:
        return MaterialPageRoute(
          builder: (_) => SignupScreen.withDependencies(),
          settings: settings,
        );
      case RoutePath.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => ForgetPasswordScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Text('No route defined for ${settings.name}')),
        );
    }
  }
}
