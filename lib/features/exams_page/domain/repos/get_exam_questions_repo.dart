import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';

abstract class GetExamQuestionsRepo {
  Future<BaseResponse<List<QuestionModel>>> getExamQuestions({
    required String token,
    required String examId,
  });
}
