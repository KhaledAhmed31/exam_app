// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';
import 'package:exam_app/features/exams_page/domain/usecases/get_exam_questions_usecase.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_events.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_states.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExamPageBloc extends Bloc<ExamPageEvents, ExamPageStates> {
  GetExamQuestionsUsecase usecase;
  final FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

  ExamPageBloc(this.usecase) : super(ExamPageStates(currentQuestion: 1)) {
    on<PreviousQuestionEvent>(_previousQuestion);
    on<NextQuestionEvent>(_nextQuestion);
    on<GetExamQuestionsEvent>(_getExamQuestions);
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

  Future<void> _getExamQuestions(
    GetExamQuestionsEvent event,
    Emitter<ExamPageStates> emit,
  ) async {
    final token = await storage.read(key: 'auth_token');

    emit(
      state.copywith(
        getQuestionStateCopywith: GetQuestionsState(isLoading: true),
      ),
    );
    BaseResponse<List<QuestionModel>> response = await usecase.call(
      token: token.toString(),
    );

    switch (response) {
      case SuccessResponse<List<QuestionModel>>():
        emit(
          state.copywith(
            getQuestionStateCopywith: GetQuestionsState(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
      case ErrorResponse<List<QuestionModel>, Failure>():
        print('<<<<<<E Error: ${response.error.message}');
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
