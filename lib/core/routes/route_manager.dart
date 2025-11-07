import 'route_path.dart';
import '../../features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.home:
        return MaterialPageRoute(
          builder: (_) => Container(),
          settings: settings,
        );
      case RoutePath.login:
        return MaterialPageRoute(
          builder: (_) => Container(),
          settings: settings,
        );
      case RoutePath.signup:
        return MaterialPageRoute(
          builder: (_) => Container(),
          settings: settings,
        );
      case RoutePath.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => ForgetPasswordScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Text(
          'No route defined for ${settings.name}',
        ),));
    }
  }
}
