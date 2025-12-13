import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/results_tap/data/datasources/exam_results_data_source.dart';
import 'package:exam_app/features/results_tap/data/mapper/results_model_mapper.dart';
import 'package:exam_app/features/results_tap/data/models/exam_result_model.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';
import 'package:exam_app/features/results_tap/domain/repositories/results_history_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ResultsHistoryRepo)
class ResultsHistoryRepoImpl implements ResultsHistoryRepo {
  final ExamResultsDataSource examResultsDataSource;
  ResultsHistoryRepoImpl(this.examResultsDataSource);
  @override
  Future<BaseResponse<ExamResultsEntity>> getResultsHistory() async {
    final response = await examResultsDataSource.getExamResults();
    switch (response) {
      case SuccessResponse<ExamResultsModel>():
        return SuccessResponse<ExamResultsEntity>(response.data.toEntity());
      case ErrorResponse<ExamResultsModel, Failure>():
        return ErrorResponse<ExamResultsEntity, Failure>(error: response.error);
      default:
        return SuccessResponse(ExamResultsEntity(results: {}));
    }
  }

  @override
  Future<BaseResponse<bool>> saveResult({
    required ExamResultsCardEntity examResult,
  }) async {
    final response = await examResultsDataSource.saveExamResult(examResult);
    switch (response) {
      case SuccessResponse<bool>():
        return SuccessResponse<bool>(response.data);
      case ErrorResponse<bool, Failure>():
        return ErrorResponse<bool, Failure>(error: response.error);
      default:
        return SuccessResponse<bool>(false);
    }
  }
}
