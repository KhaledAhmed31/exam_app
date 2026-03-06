import 'package:exam_app/core/config/base_state/base_state.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';

class ExamPageStates {
  int currentQuestion;
  int index;
  int finalScore;
  GetQuestionsState? getQuestionsState;
  final Map<int, String> selectedAnswers;
  ExamPageStates({
    this.currentQuestion = 1,
    this.getQuestionsState,
    this.index = 0,
    this.finalScore = 0,
    this.selectedAnswers = const {},
  });
  ExamPageStates copywith({
    GetQuestionsState? getQuestionStateCopywith,
    int? currentQuestion,
    int? index,
    int? finalScore,
    Map<int, String>? selectedAnswers,
  }) {
    return ExamPageStates(
      currentQuestion: currentQuestion ?? this.currentQuestion,
      getQuestionsState: getQuestionStateCopywith ?? getQuestionsState,
      index: index ?? this.index,
      finalScore: finalScore ?? this.finalScore,
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
