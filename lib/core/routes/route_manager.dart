import 'package:flutter/material.dart';
import 'route_path.dart';
import 'package:exam_app/features/explore/presentation/pages/explore_screen.dart';

import '../../features/explore/domain/entities/subject_entity.dart';
import '../../features/exams/domain/entities/exam_entity.dart';
import '../../features/exams/presentation/pages/subject_exams_screen.dart';
import '../../features/exams/presentation/pages/start_exam_screen.dart';

class RouteManager {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.home:
        return MaterialPageRoute(
          builder: (_) => const ExploreScreen(),
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
      case RoutePath.questions: // ADD THIS CASE
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
          builder: (_) => Container(),
          settings: settings,
        );
    }
  }
}
