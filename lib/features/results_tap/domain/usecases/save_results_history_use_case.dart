import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';
import 'package:exam_app/features/results_tap/domain/repositories/results_history_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveResultsHistoryUseCase {
  final ResultsHistoryRepo resultsHistoryRepo;
  SaveResultsHistoryUseCase({required this.resultsHistoryRepo});
  Future<BaseResponse<bool>> call({
    required ExamResultsCardEntity examResult,
  }) async => await resultsHistoryRepo.saveResult(examResult: examResult);
}
