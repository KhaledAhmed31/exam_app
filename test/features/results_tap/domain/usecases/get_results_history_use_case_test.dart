import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';
import 'package:exam_app/features/results_tap/domain/repositories/results_history_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exam_app/features/results_tap/domain/usecases/get_results_history_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_results_history_use_case_test.mocks.dart';

@GenerateMocks([ResultsHistoryRepo])
void main() {
  ResultsHistoryRepo mockResultsHistoryRepo = MockResultsHistoryRepo();
  GetResultsHistoryUseCase getResultsHistoryUseCase =
      GetResultsHistoryUseCase(resultsHistoryRepo: mockResultsHistoryRepo);
  test('getResultsHistoryUseCase', () async {
    when(
      mockResultsHistoryRepo.getResultsHistory(),
    ).thenAnswer((_) async => SuccessResponse(ExamResultsEntity(results: {
      '1': [
        ExamResultsCardEntity(
          examId: 'examId',
          finishDuration: 15,
          subject: "test",
          title: 'title',
          numberOfQuestions: 50,
          duration: 30,
          score: 30,
        ),
      ],
    })));
    final response = await getResultsHistoryUseCase.call();
    expect(response, isA<SuccessResponse<ExamResultsEntity>>());
    expect(
      (response as SuccessResponse<ExamResultsEntity>).data.results!.keys.first,
      '1',
    );
    expect(
      (response).data.results!.values.first.first.examId,
      'examId',
    );
  });
}
