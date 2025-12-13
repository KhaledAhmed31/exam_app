import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/exams_page/data/repos/get_exam_questions_repo_impl.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';
import 'package:exam_app/features/exams_page/domain/usecases/get_exam_questions_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_exam_questions_usecase_test.mocks.dart';

@GenerateMocks([GetExamQuestionsRepoImpl])
void main() {
  late GetExamQuestionsUsecase questionsUsecase;
  late MockGetExamQuestionsRepoImpl mockRepoImpl;
  setUpAll(() {
    mockRepoImpl = MockGetExamQuestionsRepoImpl();
    questionsUsecase = GetExamQuestionsUsecase(mockRepoImpl);
  });
  test('test success get exam questions usecase with non empty list', () async {
    List<QuestionModel> dummyQuestionModelList = [
      QuestionModel(id: '1', question: 'Q1'),
      QuestionModel(id: '2', question: 'Q2'),
    ];
    when(mockRepoImpl.getExamQuestions(examId: anyNamed('examId'))).thenAnswer(
      (_) async => SuccessResponse<List<QuestionModel>>(dummyQuestionModelList),
    );

    final result =
        await questionsUsecase.call(examId: 'examId')
            as SuccessResponse<List<QuestionModel>>;

    expect(result, isA<SuccessResponse<List<QuestionModel>>>());
    expect(result.data, dummyQuestionModelList);
    expect(result.data[0].id, dummyQuestionModelList[0].id);
    verify(mockRepoImpl.getExamQuestions(examId: 'examId')).called(1);
  });
  test('test success get exam questions usecase with empty list', () async {
    when(
      mockRepoImpl.getExamQuestions(examId: anyNamed('examId')),
    ).thenAnswer((_) async => SuccessResponse<List<QuestionModel>>([]));

    final result =
        await questionsUsecase.call(examId: 'examId')
            as SuccessResponse<List<QuestionModel>>;

    expect(result, isA<SuccessResponse<List<QuestionModel>>>());
    expect(result.data.length, isZero);
    verify(mockRepoImpl.getExamQuestions(examId: 'examId')).called(1);
  });
  test('test error get exam questions usecase', () async {
    final dummyFailure = ErrorHandler.handle(Exception('Something went wrong'));
    when(mockRepoImpl.getExamQuestions(examId: anyNamed('examId'))).thenAnswer(
      (_) async => ErrorResponse<List<QuestionModel>, Failure>(
        error: dummyFailure.failure,
      ),
    );

    final result =
        await questionsUsecase.call(examId: 'examId')
            as ErrorResponse<List<QuestionModel>, Failure>;

    expect(result, isA<ErrorResponse<List<QuestionModel>, Failure>>());
    expect(result.error.message, dummyFailure.failure.message);
    verify(mockRepoImpl.getExamQuestions(examId: 'examId')).called(1);
  });
}
