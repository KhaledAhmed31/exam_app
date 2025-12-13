import 'package:exam_app/features/results_tap/data/models/exam_result_model.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';

extension ResultsModelMapper on ExamResultsModel {
  ExamResultsEntity toEntity() {
    return ExamResultsEntity(
      results: results.map(
        (subject, examList) => MapEntry(
          subject,
          examList
              .map(
                (e) => ExamResultsCardEntity(
                  duration: e.duration,
                  finishDuration: e.finishDuration,
                  title: e.title,
                  numberOfQuestions: e.numberOfQuestions,
                  score: e.score,
                  examId: e.examId,
                  subject: e.subject,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
