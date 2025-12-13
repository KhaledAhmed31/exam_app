import 'package:bloc_test/bloc_test.dart';
import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';
import 'package:exam_app/features/exams_page/domain/usecases/get_exam_questions_usecase.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_bloc.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_events.dart';
import 'package:exam_app/features/exams_page/presentation/bloc/exam_page_states.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'exam_page_bloc_test.mocks.dart';

@GenerateMocks([GetExamQuestionsUsecase])
void main() {
  late MockGetExamQuestionsUsecase mockGetExamQuestionsUsecase;
  late ExamPageBloc bloc;
  setUpAll(() {
    mockGetExamQuestionsUsecase = MockGetExamQuestionsUsecase();
  });

  setUp(() {
    bloc = ExamPageBloc(mockGetExamQuestionsUsecase);
  });

  blocTest<ExamPageBloc, ExamPageStates>(
    'Test get questions with emits loading, success states',
    build: () {
      List<QuestionModel> dummyQModelList = [
        QuestionModel(id: '1', question: 'Q1', correct: 'A'),
        QuestionModel(id: '2', question: 'Q2', correct: 'A'),
      ];
      when(mockGetExamQuestionsUsecase.call(examId: 'examId')).thenAnswer(
        (_) async => SuccessResponse<List<QuestionModel>>(dummyQModelList),
      );
      return bloc;
    },

    act: (bloc) => bloc.add(GetExamQuestionsEvent(examId: 'examId')),

    expect: () => [
      // first state loading true
      isA<ExamPageStates>().having(
        (s) => s.getQuestionsState!.isLoading,
        'isLoading',
        true,
      ),

      // second state loading false + data
      isA<ExamPageStates>()
          .having((s) => s.getQuestionsState!.isLoading, 'isLoading', false)
          .having((s) => s.getQuestionsState!.data!.length, 'data', 2)
          .having((s) => s.index, 'index', 0),
    ],
  );

  blocTest<ExamPageBloc, ExamPageStates>(
    'Test get questions with emits loading, error states',
    build: () {
      final dummyFailure = ErrorHandler.handle(
        Exception('Something went wrong'),
      );
      when(mockGetExamQuestionsUsecase.call(examId: ('examId'))).thenAnswer(
        (_) async => ErrorResponse<List<QuestionModel>, Failure>(
          error: dummyFailure.failure,
        ),
      );
      return bloc;
    },

    act: (bloc) => bloc.add(GetExamQuestionsEvent(examId: 'examId')),

    expect: () => [
      // first state → Loading true
      isA<ExamPageStates>().having(
        (s) => s.getQuestionsState!.isLoading,
        'isLoading',
        true,
      ),

      // sec state → Error
      isA<ExamPageStates>()
          .having(
            (s) => s.getQuestionsState!.errorMessage,
            'errorMessage',
            'An error occurred. Please try again later.',
          )
          .having((s) => s.getQuestionsState!.isLoading, 'isLoading', false),
    ],
  );

  blocTest<ExamPageBloc, ExamPageStates>(
    'test emit selectedAnswers',

    build: () {
      return bloc;
    },

    act: (bloc) {
      bloc.add(SelectAnswer(0, "A"));
    },

    expect: () => [
      isA<ExamPageStates>().having(
        (state) => state.selectedAnswers[0],
        'selectedAnswers[0]',
        "A",
      ),
    ],
  );

  blocTest<ExamPageBloc, ExamPageStates>(
    'test emit previous question',
    build: () {
      bloc.emit(bloc.state.copywith(currentQuestion: 3, index: 2));
      return bloc;
    },

    act: (bloc) => bloc.add(PreviousQuestionEvent()),

    expect: () => [
      isA<ExamPageStates>()
          .having((s) => s.currentQuestion, "currentQuestion", 2)
          .having((s) => s.index, "index", 1),
    ],
  );

  group('test next question', () {
    blocTest<ExamPageBloc, ExamPageStates>(
      'test emit next question and save answers',
      build: () {
        bloc.emit(
          bloc.state.copywith(
            currentQuestion: 1,
            index: 0,
            selectedAnswers: {},
            getQuestionStateCopywith: GetQuestionsState(
              data: [
                QuestionModel(correct: 'A'),
                QuestionModel(correct: 'B'),
              ],
            ),
          ),
        );
        return bloc;
      },

      act: (bloc) => bloc.add(NextQuestionEvent(selectedAnswerKey: 'A')),

      expect: () => [
        isA<ExamPageStates>()
            .having((s) => s.currentQuestion, "currentQuestion", 2)
            .having((s) => s.index, "index", 1)
            .having((s) => s.selectedAnswers, "selectedAnswer", {0: "A"}),
      ],
    );

    blocTest<ExamPageBloc, ExamPageStates>(
      'test emit next question calculate score on last one',

      build: () {
        bloc.emit(
          bloc.state.copywith(
            currentQuestion: 2,
            index: 1,
            selectedAnswers: {0: "A"},
            getQuestionStateCopywith: GetQuestionsState(
              data: [
                QuestionModel(correct: 'A'),
                QuestionModel(correct: 'B'),
              ],
            ),
          ),
        );
        return bloc;
      },

      act: (bloc) => bloc.add(NextQuestionEvent(selectedAnswerKey: 'B')),

      expect: () => [
        isA<ExamPageStates>()
            .having((s) => s.finalScore, 'finalScore  ', 100)
            .having((s) => s.selectedAnswers, "selectedAnswer", {
              0: "A",
              1: "B",
            }),
      ],
    );
  });

  blocTest<ExamPageBloc, ExamPageStates>(
    'Test emit finish exam',
    build: () {
      bloc.emit(
        bloc.state.copywith(
          selectedAnswers: {0: "A", 1: "X"},
          getQuestionStateCopywith: GetQuestionsState(
            data: [
              QuestionModel(correct: "A"),
              QuestionModel(correct: "B"),
            ],
          ),
        ),
      );
      return bloc;
    },

    act: (bloc) => bloc.add(FinishExamEvent()),

    expect: () => [
      isA<ExamPageStates>().having((s) => s.finalScore, 'finalScore ', 50),
    ],
  );
}
