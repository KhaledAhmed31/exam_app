import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/exams_page/api/api_client/exam_questions_api_client.dart';
import 'package:exam_app/features/exams_page/api/datasources/get_exam_questions_remote_datasource_impl.dart';
import 'package:exam_app/features/exams_page/data/models/exam_questions_dto.dart';
import 'package:exam_app/features/exams_page/data/models/question_dto.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_exam_questions_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ExamQuestionsApiClient])
void main() {
  late GetExamQuestionsRemoteDatasourceImpl remoteDatasourceImpl;
  late MockExamQuestionsApiClient mockApiClient;
  setUpAll(() {
    mockApiClient = MockExamQuestionsApiClient();
    remoteDatasourceImpl = GetExamQuestionsRemoteDatasourceImpl(mockApiClient);
  });

  test(
    'test exam questions remote datasource impl success case with non empty list',
    () async {
      List<QuestionDto> dummyQuestionsDto = [
        QuestionDto(id: '1', question: 'Q1', correct: 'A'),
        QuestionDto(id: '2', question: 'Q2', correct: 'A'),
      ];
      when(mockApiClient.getExamQuestions('examId')).thenAnswer(
        (_) async => ExamQuestionsResponse(questions: dummyQuestionsDto),
      );

      final result =
          await remoteDatasourceImpl.getExamQuestions(examId: 'examId')
              as SuccessResponse<List<QuestionDto>>;

      expect(result, isA<SuccessResponse<List<QuestionDto>>>());
      expect(result.data.length, dummyQuestionsDto.length);
      expect(result.data[0].id, dummyQuestionsDto[0].id);
      verify(mockApiClient.getExamQuestions('examId')).called(1);
    },
  );
  test(
    'test exam questions remote datasource impl success case with empty list',
    () async {
      when(
        mockApiClient.getExamQuestions('examId'),
      ).thenAnswer((_) async => ExamQuestionsResponse(questions: []));

      final result =
          await remoteDatasourceImpl.getExamQuestions(examId: 'examId')
              as SuccessResponse<List<QuestionDto>>;

      expect(result, isA<SuccessResponse<List<QuestionDto>>>());
      expect(result.data.length, isZero);
      verify(mockApiClient.getExamQuestions('examId')).called(1);
    },
  );
  test('test exam questions remote datasource impl error case', () async {
    final dummyFailure = ErrorHandler.handle(Exception('Something went wrong'));
    when(mockApiClient.getExamQuestions('examId')).thenThrow(dummyFailure);

    final result = await remoteDatasourceImpl.getExamQuestions(
      examId: 'examId',
    );

    expect(result, isA<ErrorResponse>());
    expect(
      (result as ErrorResponse).error.failure.message,
      dummyFailure.failure.message,
    );
    verify(mockApiClient.getExamQuestions('examId')).called(1);
  });
}
