import 'package:bloc/bloc.dart';
import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';
import 'package:exam_app/features/exams_page/domain/usecases/get_exam_questions_usecase.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_events.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_states.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@injectable
class ExamPageBloc extends Bloc<ExamPageEvents, ExamPageStates> {
  GetExamQuestionsUsecase usecase;
  var logger = Logger();
  ExamPageBloc(this.usecase) : super(ExamPageStates()) {
    on<PreviousQuestionEvent>(_previousQuestion);
    on<NextQuestionEvent>(_nextQuestion);
    on<GetExamQuestionsEvent>(_getExamQuestions);
    on<SelectAnswer>(_onSelectedAnswer);
    on<FinishExamEvent>(_finishExam);
  }
  Future<void> _getExamQuestions(
    GetExamQuestionsEvent event,
    Emitter<ExamPageStates> emit,
  ) async {
    emit(
      state.copywith(
        getQuestionStateCopywith: GetQuestionsState(isLoading: true),
      ),
    );
    BaseResponse<List<QuestionModel>> response = await usecase.call(
      examId: event.examId.toString(),
    );
    switch (response) {
      case SuccessResponse<List<QuestionModel>>():
        emit(
          state.copywith(
            getQuestionStateCopywith: GetQuestionsState(
              isLoading: false,
              data: response.data,
              totalQuestions: response.data.length,
            ),
            selectedAnswers: {},
            currentQuestion: 1,
            index: 0,
            finalScore: 0,
          ),
        );
        break;
      case ErrorResponse<List<QuestionModel>, Failure>():
        emit(
          state.copywith(
            getQuestionStateCopywith: GetQuestionsState(
              isLoading: false,
              errorMessage: response.error.message,
            ),
          ),
        );
    }
  }

  void _onSelectedAnswer(SelectAnswer event, Emitter<ExamPageStates> emit) {
    final updatedAnswers = Map<int, String>.from(state.selectedAnswers);
    updatedAnswers[event.questionIndex] = event.answerKey;
    emit(state.copywith(selectedAnswers: updatedAnswers));
  }

  void _previousQuestion(
    PreviousQuestionEvent event,
    Emitter<ExamPageStates> emit,
  ) {
    if (state.currentQuestion > 1) {
      emit(
        state.copywith(
          currentQuestion: state.currentQuestion - 1,
          index: state.index - 1,
        ),
      );
    }
  }

  void _nextQuestion(NextQuestionEvent event, Emitter<ExamPageStates> emit) {
    final questions = state.getQuestionsState?.data;
    if (questions == null || questions.isEmpty) return;

    final updatedAnswers = Map<int, String>.from(state.selectedAnswers);
    if (event.selectedAnswerKey != null) {
      updatedAnswers[state.index] = event.selectedAnswerKey!;
    }

    if (state.currentQuestion < questions.length) {
      emit(
        state.copywith(
          currentQuestion: state.currentQuestion + 1,
          index: state.index + 1,
          selectedAnswers: updatedAnswers,
        ),
      );
      logger.d('<<<<<<<<<<<<<< selectedAnswers ${state.selectedAnswers} ');
      return;
    }
    final score = _calculateScore(updatedAnswers);
    emit(state.copywith(selectedAnswers: updatedAnswers, finalScore: score));
  }

  void _finishExam(FinishExamEvent event, Emitter<ExamPageStates> emit) {
    final score = _calculateScore(state.selectedAnswers);
    emit(state.copywith(finalScore: score));
  }

  int _calculateScore(Map<int, String> answers) {
    final questions = state.getQuestionsState?.data;
    if (questions == null || questions.isEmpty) return 0;

    int correctCount = 0;
    for (int i = 0; i < questions.length; i++) {
      if (answers[i] == questions[i].correct) {
        correctCount++;
      }
    }
    return ((correctCount / questions.length) * 100).toInt();
  }
}
