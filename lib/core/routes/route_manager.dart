import 'package:exam_app/core/routes/route_path.dart';
import 'package:exam_app/features/auth/login/presentation/views/screens/home_screen.dart';
import 'package:exam_app/features/auth/login/presentation/views/screens/login_screen.dart';
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
          builder: (_) => Container(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
