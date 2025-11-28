import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';
import 'package:exam_app/features/results_tap/domain/repositories/results_history_repo.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as: ResultsHistoryRepo)
class ResultsHistoryRepoImpl implements ResultsHistoryRepo{
  @override
  Future<ExamResultsEntity> getResultsHistory() {
    // TODO: implement getResultsHistory
    throw UnimplementedError();
  }

  @override
  Future<bool> saveResult({required ExamResultsCardEntity examResult}) {
    // TODO: implement saveResult
    throw UnimplementedError();
  }
}