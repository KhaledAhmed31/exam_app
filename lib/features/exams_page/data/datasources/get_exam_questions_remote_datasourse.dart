import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/exams_page/data/models/question_dto.dart';

abstract class GetExamQuestionsRemoteDatasourse {
  Future<BaseResponse<List<QuestionDto>>> getExamQuestions({required String token});
}
