import 'package:exam_app/core/config/base_state/base_state.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';

class ExamPageStates {
  int? currentQuestion;
  int? totalQuestions;
  GetQuestionsState? getQuestionsState;
  ExamPageStates({
    this.currentQuestion,
    this.totalQuestions,
    this.getQuestionsState,
  });
  ExamPageStates copywith({GetQuestionsState? getQuestionStateCopywith, int? currentQuestion, int? totalQuestions}) {
    return ExamPageStates(
      currentQuestion: currentQuestion ?? this.currentQuestion,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      getQuestionsState: getQuestionStateCopywith ?? getQuestionsState,
    );
  }
}

class GetQuestionsState extends BaseState<List<QuestionModel>> {
  GetQuestionsState({super.isLoading, super.data, super.errorMessage});
}
