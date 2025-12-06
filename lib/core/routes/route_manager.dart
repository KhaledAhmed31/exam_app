import 'package:exam_app/features/exams_page/presentation/screens/exam_results_screen.dart';
import 'package:exam_app/features/exams_page/presentation/screens/exam_score_screen.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/features/explore/domain/entities/subject_entity.dart';
import 'package:exam_app/features/subject%20details/presentation/pages/subject_details_screen.dart';
import 'package:exam_app/features/exams_page/presentation/screens/exam_page_screen.dart';
import 'package:exam_app/features/exams/domain/entities/exam_entity.dart';
import 'package:exam_app/features/exams/presentation/pages/subject_exams_screen.dart';
import 'package:exam_app/features/exams/presentation/pages/start_exam_screen.dart';
import 'package:exam_app/features/home/presentation/screens/home_screen.dart';
import 'package:exam_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:exam_app/features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import 'route_path.dart';

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
      case RoutePath.subjectExams:
        final subject = settings.arguments as SubjectEntity;
        return MaterialPageRoute(
          builder: (_) => SubjectExamsScreen(subject: subject),
          settings: settings,
        );
      case RoutePath.startExam:
        final args = settings.arguments;
        ExamEntity exam;
        if (args is ExamEntity) {
          exam = args;
        } else if (args is Map && args['exam'] is ExamEntity) {
          exam = args['exam'] as ExamEntity;
        } else {
          return MaterialPageRoute(builder: (_) => const SizedBox.shrink());
        }
        return MaterialPageRoute(
          builder: (_) => StartExamScreen(exam: exam),
          settings: settings,
        );
      case RoutePath.questions:
        final examId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Questions')),
            body: Center(
              child: Text(
                'Questions Screen - Coming from Mariam\nExam ID: $examId',
              ),
            ),
          ),
          settings: settings,
        );
      case RoutePath.examPage:
        return MaterialPageRoute(
          builder: (_) => ExamPageScreen(),
          settings: settings,
        );
      case RoutePath.examScore:
        return MaterialPageRoute(
          builder: (_) => ExamScoreScreen(),
          settings: settings,
        );
      case RoutePath.examResults:
        return MaterialPageRoute(
          builder: (_) => ExamResultsScreen(),
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
