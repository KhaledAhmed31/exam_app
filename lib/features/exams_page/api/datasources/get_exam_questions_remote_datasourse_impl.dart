// ignore_for_file: avoid_print

import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/exams_page/api/api_client/exam_questions_api_client.dart';
import 'package:exam_app/features/exams_page/data/datasources/get_exam_questions_remote_datasourse.dart';
import 'package:exam_app/features/exams_page/data/models/exam_questions_dto.dart';
import 'package:exam_app/features/exams_page/data/models/question_dto.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: GetExamQuestionsRemoteDatasourse)
class GetExamQuestionsRemoteDatasourseImpl
    implements GetExamQuestionsRemoteDatasourse {
  ExamQuestionsApiClient apiClient;
  GetExamQuestionsRemoteDatasourseImpl(this.apiClient);

  @override
  Future<BaseResponse<List<QuestionDto>>> getExamQuestions({
    required String token,
    required String examId,
  }) async {
    print('<<<<<< DATE SOUSRCE $token');
    try {
      ExamQuestionsResponse questionsResponse = await apiClient
          .getExamQuestions(token, examId);
      List<QuestionDto> list = questionsResponse.questions ?? [];

      return SuccessResponse<List<QuestionDto>>(list);
    } catch (e) {
      print('<<<<<<<<< Data source Error occurred: $e');
      return ErrorResponse(error: ErrorHandler.handle(e));
    }
  }
}
