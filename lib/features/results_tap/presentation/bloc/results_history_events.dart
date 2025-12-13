import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';

abstract class ResultsHistoryEvents {}
class LoadResultsHistoryEvent extends ResultsHistoryEvents {}
class SaveExamResultEvent extends ResultsHistoryEvents {
  final ExamResultsCardEntity examResult;
  SaveExamResultEvent({required this.examResult});
}
