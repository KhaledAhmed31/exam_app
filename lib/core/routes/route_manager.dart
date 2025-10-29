import 'package:exam_app/core/routes/route_path.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.home:
        return MaterialPageRoute(builder: (_) => Container(),settings: settings);
      case RoutePath.login:
        return MaterialPageRoute(builder: (_) => Container(),settings: settings);
      case RoutePath.signup:
        return MaterialPageRoute(builder: (_) => Container(),settings: settings);
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}