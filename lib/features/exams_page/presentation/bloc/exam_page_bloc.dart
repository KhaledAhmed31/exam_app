import 'package:bloc/bloc.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_events.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExamPageBloc extends Bloc<ExamPageEvents, ExamPageStates> {
  ExamPageBloc()
    : super(ExamPageStates(currentQuestion: 1, totalQuestions: 20)) {
    on<PreviousQuestionEvent>(_previousQuestion);
    on<NextQuestionEvent>(_nextQuestion);
  }

  void _previousQuestion(
    PreviousQuestionEvent event,
    Emitter<ExamPageStates> emit,
  ) {
    if (state.currentQuestion! > 1) {
      emit(
        ExamPageStates(
          currentQuestion: state.currentQuestion! - 1,
          totalQuestions: state.totalQuestions,
        ),
      );
    }
  }

  void _nextQuestion(NextQuestionEvent event, Emitter<ExamPageStates> emit) {
    if (state.currentQuestion! < state.totalQuestions!) {
      emit(
        ExamPageStates(
          currentQuestion: state.currentQuestion! + 1,
          totalQuestions: state.totalQuestions,
        ),
      );
    }
  }
}
