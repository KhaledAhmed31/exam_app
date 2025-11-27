import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/exams_page/api/api_client/exam_questions_api_client.dart';
import 'package:exam_app/features/exams_page/data/datasources/get_exam_questions_remote_datasource.dart';
import 'package:exam_app/features/exams_page/data/models/exam_questions_dto.dart';
import 'package:exam_app/features/exams_page/data/models/question_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetExamQuestionsRemoteDatasource)
class GetExamQuestionsRemoteDatasourceImpl
    implements GetExamQuestionsRemoteDatasource {
  ExamQuestionsApiClient apiClient;
  GetExamQuestionsRemoteDatasourceImpl(this.apiClient);

  @override
  Future<BaseResponse<List<QuestionDto>>> getExamQuestions({
    required String examId,
  }) async {
    try {
      ExamQuestionsResponse questionsResponse = await apiClient
          .getExamQuestions(examId);
      List<QuestionDto> list = questionsResponse.questions ?? [];

      return SuccessResponse<List<QuestionDto>>(list);
    } catch (e) {
      return ErrorResponse(error: ErrorHandler.handle(e));
    }
  }
}
