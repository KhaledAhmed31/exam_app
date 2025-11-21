import 'package:exam_app/core/config/base_state/base_state.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';

class ExamPageStates {
  int currentQuestion;
  int index;
  GetQuestionsState? getQuestionsState;
  final Map<int, int> selectedAnswers;
  ExamPageStates({
    this.currentQuestion = 1,
    this.getQuestionsState,
    this.index = 0,
    this.selectedAnswers = const {},
  });
  ExamPageStates copywith({
    GetQuestionsState? getQuestionStateCopywith,
    int? currentQuestion,
    int? index,
    Map<int, int>? selectedAnswers,
  }) {
    return ExamPageStates(
      currentQuestion: currentQuestion ?? this.currentQuestion,
      getQuestionsState: getQuestionStateCopywith ?? getQuestionsState,
      index: index ?? this.index,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
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
