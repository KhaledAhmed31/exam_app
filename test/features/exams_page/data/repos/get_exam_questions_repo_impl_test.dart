import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/exams_page/api/datasources/get_exam_questions_remote_datasource_impl.dart';
import 'package:exam_app/features/exams_page/data/models/question_dto.dart';
import 'package:exam_app/features/exams_page/data/repos/get_exam_questions_repo_impl.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'get_exam_questions_repo_impl_test.mocks.dart';

@GenerateMocks([GetExamQuestionsRemoteDatasourceImpl])
void main() {
  late GetExamQuestionsRepoImpl questionsRepoImpl;
  late MockGetExamQuestionsRemoteDatasourceImpl mockRemoteDatasourceImpl;
  setUpAll(() {
    /// ARRANGE
    provideDummy<BaseResponse<List<QuestionDto>>>(
      SuccessResponse<List<QuestionDto>>([]),
    );
    provideDummy<BaseResponse<List<QuestionModel>>>(
      SuccessResponse<List<QuestionModel>>([]),
    );

    mockRemoteDatasourceImpl = MockGetExamQuestionsRemoteDatasourceImpl();
    questionsRepoImpl = GetExamQuestionsRepoImpl(mockRemoteDatasourceImpl);
  });

  test('Test Success Case with questionDto non empty list', () async {
    List<QuestionDto> dummyQuestionsDtoList = [
      QuestionDto(
        id: '1',
        question: 'What is Flutter?1',
        answers: [
          AnswerDto(answer: 'A', key: 'A'),
          AnswerDto(answer: 'B', key: 'B'),
          AnswerDto(answer: 'C', key: 'C'),
          AnswerDto(answer: 'D', key: 'D'),
        ],
        correct: 'A',
        exam: ExamDto(id: 'exam1', title: 'Html Exam1'),
      ),
      QuestionDto(
        id: '2',
        question: 'What is Flutter?2',
        answers: [
          AnswerDto(answer: 'A', key: 'A'),
          AnswerDto(answer: 'B', key: 'B'),
          AnswerDto(answer: 'C', key: 'C'),
          AnswerDto(answer: 'D', key: 'D'),
        ],
        correct: 'A',
        exam: ExamDto(id: 'exam2', title: 'Html Exam2'),
      ),
    ];
    when(
      mockRemoteDatasourceImpl.getExamQuestions(examId: ('examId')),
    ).thenAnswer(
      (_) async => SuccessResponse<List<QuestionDto>>(dummyQuestionsDtoList),
    );

    final result =
        await questionsRepoImpl.getExamQuestions(examId: 'examId')
            as SuccessResponse<List<QuestionModel>>;

    expect(result, isA<SuccessResponse<List<QuestionModel>>>());
    expect(result.data.length, dummyQuestionsDtoList.length);
    expect(result.data[0].correct, dummyQuestionsDtoList[0].correct);
    expect(result.data[0].question, dummyQuestionsDtoList[0].question);
    expect(
      result.data[0].answers![0].answer,
      dummyQuestionsDtoList[0].answers![0].answer,
    );
    expect(result.data[0].exam!.id, dummyQuestionsDtoList[0].exam!.id);
    expect(result.data[1].correct, dummyQuestionsDtoList[1].correct);
    expect(result.data[1].question, dummyQuestionsDtoList[1].question);
    expect(
      result.data[1].answers![0].answer,
      dummyQuestionsDtoList[1].answers![0].answer,
    );
    verify(
      mockRemoteDatasourceImpl.getExamQuestions(examId: 'examId'),
    ).called(1);
  });

  test('Test Success Case with questionDto empty list', () async {
    when(
      mockRemoteDatasourceImpl.getExamQuestions(examId: anyNamed('examId')),
    ).thenAnswer((_) async => SuccessResponse<List<QuestionDto>>([]));

    final result =
        await questionsRepoImpl.getExamQuestions(examId: 'examId')
            as SuccessResponse<List<QuestionModel>>;

    expect(result, isA<SuccessResponse<List<QuestionModel>>>());
    expect(result.data.length, isZero);
    verify(
      mockRemoteDatasourceImpl.getExamQuestions(examId: 'examId'),
    ).called(1);
  });

  test('Test Error Case', () async {
    final dummyFailure = ErrorHandler.handle(Exception('Something went wrong'));
    when(
      mockRemoteDatasourceImpl.getExamQuestions(examId: anyNamed('examId')),
    ).thenAnswer(
      (_) async =>
          ErrorResponse<List<QuestionDto>, ErrorHandler>(error: dummyFailure),
    );

    final result =
        await questionsRepoImpl.getExamQuestions(examId: 'examId')
            as ErrorResponse<List<QuestionModel>, Failure>;

    expect(result, isA<ErrorResponse<List<QuestionModel>, Failure>>());
    expect(result.error.message, dummyFailure.failure.message);
    expect(result.error.statusCode, dummyFailure.failure.statusCode);
    verify(
      mockRemoteDatasourceImpl.getExamQuestions(examId: 'examId'),
    ).called(1);
  });
}
