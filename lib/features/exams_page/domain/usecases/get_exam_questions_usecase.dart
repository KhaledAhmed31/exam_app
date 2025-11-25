import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';
import 'package:exam_app/features/exams_page/domain/repos/get_exam_questions_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetExamQuestionsUsecase {
  GetExamQuestionsRepo getExamQuestionsRepo;
  GetExamQuestionsUsecase(this.getExamQuestionsRepo);

  Future<BaseResponse<List<QuestionModel>>> call({
    required String examId,
  }) => getExamQuestionsRepo.getExamQuestions(examId: examId);
}
