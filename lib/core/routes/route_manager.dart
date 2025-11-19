import 'package:exam_app/features/explore/domain/entities/subject_entity.dart';
import 'package:exam_app/features/subject%20details/presentation/pages/subject_details_screen.dart';

import 'route_path.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/auth/login/presentation/screens/login_screen.dart';
import '../../features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.home:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
          settings: settings,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
                ),
                child: child,
              ),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );
      case RoutePath.login:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              LoginScreen(),
          settings: settings,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
                ),
                child: child,
              ),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );
      case RoutePath.signup:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Container(),
          settings: settings,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
                ),
                child: child,
              ),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );
      case RoutePath.forgetPassword:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ForgetPasswordScreen(),
          settings: settings,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
                ),
                child: child,
              ),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );
      case RoutePath.subjectDetails:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SubjectDetailsScreen(
                subject: settings.arguments as SubjectEntity,
              ),
          settings: settings,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
                ),
                child: child,
              ),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Text('No route defined for ${settings.name}')),
        );
    }
  }
}
