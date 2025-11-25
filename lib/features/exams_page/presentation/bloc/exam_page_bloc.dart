import 'package:bloc/bloc.dart';
import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';
import 'package:exam_app/features/exams_page/domain/usecases/get_exam_questions_usecase.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_events.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExamPageBloc extends Bloc<ExamPageEvents, ExamPageStates> {
  GetExamQuestionsUsecase usecase;

  ExamPageBloc(this.usecase) : super(ExamPageStates()) {
    on<PreviousQuestionEvent>(_previousQuestion);
    on<NextQuestionEvent>(_nextQuestion);
    on<GetExamQuestionsEvent>(_getExamQuestions);
    on<SelectAnswer>(_onSelectedAnswer);
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
    if (state.getQuestionsState != null) {
      if (state.currentQuestion < state.getQuestionsState!.totalQuestions) {
        emit(
          state.copywith(
            currentQuestion: state.currentQuestion + 1,
            index: state.index + 1,
          ),
        );
      }
    }
  }

  void _onSelectedAnswer(SelectAnswer event, Emitter<ExamPageStates> emit) {
    final updatedAnswers = Map<int, int>.from(state.selectedAnswers);
    updatedAnswers[event.questionIndex] = event.answerIndex;
    emit(state.copywith(selectedAnswers: updatedAnswers));
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
          ),
        );
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
}
