import 'package:exam_app/core/config/base_state/base_state.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';

class ExamPageStates {
  int currentQuestion;
  int index;
  GetQuestionsState? getQuestionsState;
  ExamPageStates({
    this.currentQuestion = 1,
    this.getQuestionsState,
    this.index = 0,
  });
  ExamPageStates copywith({
    GetQuestionsState? getQuestionStateCopywith,
    int? currentQuestion,
    int? index,
  }) {
    return ExamPageStates(
      currentQuestion: currentQuestion ?? this.currentQuestion,
      getQuestionsState: getQuestionStateCopywith ?? getQuestionsState,
      index: index ?? this.index,
    );
  }
}

class GetQuestionsState extends BaseState<List<QuestionModel>> {
  int totalQuestions;

  GetQuestionsState({
    super.isLoading,
    super.data,
    super.errorMessage,
    this.totalQuestions = 1,
  });
}
