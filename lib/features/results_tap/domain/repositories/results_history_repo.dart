import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';

abstract class ResultsHistoryRepo {
  Future<BaseResponse<bool>> saveResult({required ExamResultsCardEntity examResult});
  Future<BaseResponse<ExamResultsEntity>> getResultsHistory();
}
