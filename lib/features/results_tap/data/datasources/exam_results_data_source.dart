import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/results_tap/data/models/exam_result_model.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

@lazySingleton
class ExamResultsDataSource {
  final Database db;

  ExamResultsDataSource({required this.db});

  Future<BaseResponse<bool>> saveExamResult(
    ExamResultsCardEntity examResult,
  ) async {
    try {
      await db.transaction((txn) async {
        await txn.insert('exams', {
          'examId': examResult.examId,
          'examTitle': examResult.title,
          'finishDuration': examResult.finishDuration,
          'questions': examResult.numberOfQuestions,
          'correct': examResult.score,
          'time': examResult.duration,
        });

        await txn.insert('results', {
          'subjectName': examResult.subject,
          'examId': examResult.examId,
        });
      });
      return SuccessResponse(true);
    } catch (e) {
      return ErrorResponse(error: ErrorHandler.handle(e));
    }
  }

  Future<BaseResponse<ExamResultsModel>> getExamResults() async {
    try {
      final List<Map<String, dynamic>> exams = await db.query('exams');
      final List<Map<String, dynamic>> results = await db.query('results');

      Map<String, List<ExamResultCardModel>> groupedResults = {};

      for (var result in results) {
        final exam = exams.firstWhere((e) => e['examId'] == result['examId']);
        final examResultModel = ExamResultCardModel(
          subject: result['subjectName'],
          finishDuration: exam['finishDuration'],
          title: exam['examTitle'],
          numberOfQuestions: exam['questions'],
          duration: exam['time'],
          score: exam['correct'],
          examId: exam['examId'],
        );

        if (!groupedResults.containsKey(result['subjectName'])) {
          groupedResults[result['subjectName']] = [];
        }
        groupedResults[result['subjectName']]!.add(examResultModel);
      }
      return SuccessResponse(ExamResultsModel(results: groupedResults));
    } catch (e) {
      return ErrorResponse(error: ErrorHandler.handle(e));
    }
  }
}
