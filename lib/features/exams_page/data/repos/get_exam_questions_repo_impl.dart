import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/exams_page/data/datasources/get_exam_questions_remote_datasourse.dart';
import 'package:exam_app/features/exams_page/data/mappers/question_dto_mapper.dart';
import 'package:exam_app/features/exams_page/data/models/question_dto.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';
import 'package:exam_app/features/exams_page/domain/repos/get_exam_questions_repo.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: GetExamQuestionsRepo)
class GetExamQuestionsRepoImpl implements GetExamQuestionsRepo {
  GetExamQuestionsRemoteDatasourse getExamQuestionsRemoteDatasourse;
  GetExamQuestionsRepoImpl(this.getExamQuestionsRemoteDatasourse);

  @override
  Future<BaseResponse<List<QuestionModel>>> getExamQuestions({
    required String token,
    required String examId,
  }) async {
    BaseResponse<List<QuestionDto>> questionsResponse =
        await getExamQuestionsRemoteDatasourse.getExamQuestions(
          token: token,
          examId: examId,
        );

    switch (questionsResponse) {
      case SuccessResponse<List<QuestionDto>>():
        List<QuestionDto> dto = questionsResponse.data;
        List<QuestionModel> questionsModel = dto
            .map((e) => e.toQuestionsModel())
            .toList();
        return SuccessResponse<List<QuestionModel>>(questionsModel);

      case ErrorResponse<List<QuestionDto>, ErrorHandler>():
        return ErrorResponse<List<QuestionModel>, Failure>(
          error: questionsResponse.error.failure,
        );
      default:
        throw Exception('Unexpected response type from loginRemoteDatasource');
    }
  }
}
