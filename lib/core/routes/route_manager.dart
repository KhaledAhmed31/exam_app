import 'package:exam_app/core/routes/route_path.dart';
import 'package:exam_app/features/home/presentation/screens/home_screen.dart';
import 'package:exam_app/features/auth/login/presentation/screens/login_screen.dart';
import '../../features/auth/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/features/explore/domain/entities/subject_entity.dart';
import '../../features/exams/domain/entities/exam_entity.dart';
import '../../features/exams/presentation/pages/subject_exams_screen.dart';
import '../../features/exams/presentation/pages/start_exam_screen.dart';

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
      case RoutePath.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => ForgetPasswordScreen(),
          settings: settings,
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
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Text('No route defined for ${settings.name}')),
        );
    }
  }
}
