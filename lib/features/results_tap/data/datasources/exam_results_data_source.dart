import 'package:exam_app/features/results_tap/data/models/exam_result_model.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
@lazySingleton
class ExamResultsDataSource {
  final Database db;

  ExamResultsDataSource({required this.db});

  Future<void> saveExamResult(ExamResultCardModel examResult) async {
    db.transaction((txn) async {
      await txn.insert('exams', {
        'examId': examResult.examId,
        'examTitle': examResult.title,
        'questions': examResult.numberOfQuestions,
        'correct': examResult.score,
        'time': examResult.duration,
      });

      await txn.insert('results', {
        'subjectName': examResult.subject,
        'examId': examResult.examId,
      });
    });
  }

  Future<Map<String,List<ExamResultCardModel>>> getExamResults() async {
    final List<Map<String, dynamic>> exams = await db.query('exams');
    final List<Map<String, dynamic>> results = await db.query('results');

    // Group results by subject
    Map<String, List<ExamResultCardModel>> groupedResults = {};

    for (var result in results) {
      final exam = exams.firstWhere((e) => e['examId'] == result['examId']);
      final examResultModel = ExamResultCardModel(
        subject: result['subjectName'],
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

    return groupedResults;
  }

  //   final List<Map<String, dynamic>> result = await db.rawQuery('''
  //     SELECT e.examTitle, r.subjectName, e.questions, e.correct, e.time
  //     FROM exams e
  //     JOIN results r ON e.examId = r.examId
  //   ''');

  //   return result.map((row) {
  //     return ExamResultModel(
  //       subject: row['subjectName'],
  //       title: row['examTitle'],
  //       numberOfQuestions: row['questions'],
  //       duration: row['time'],
  //       score: row['correct'],
  //     );
  //   }).toList();
  // }
}
