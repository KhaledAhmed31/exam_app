import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';

abstract class ResultsHistoryRepo {
  Future<bool> saveResult({required ExamResultsCardEntity examResult});
  Future<ExamResultsEntity> getResultsHistory();
}
