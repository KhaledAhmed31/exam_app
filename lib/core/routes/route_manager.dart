import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/routes/route_path.dart';
import 'package:exam_app/features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:exam_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:exam_app/features/exams_page/presentation/screens/exam_page_screen.dart';
import 'package:exam_app/features/home/presentation/screens/home_screen.dart';
import 'package:exam_app/features/signup/presentation/screens/signup_screen.dart';
import 'package:exam_app/features/signup/view_model/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          builder: (_) => BlocProvider(
            create: (_) => getIt<SignupCubit>(),
            child: const SignupScreen(),
          ),
          settings: settings,
        );
      case RoutePath.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => ForgetPasswordScreen(),
          settings: settings,
        );
      case RoutePath.examPage:
        return MaterialPageRoute(
          builder: (_) => ExamPageScreen(),
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
