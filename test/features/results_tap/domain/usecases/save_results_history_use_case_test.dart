import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';
import 'package:exam_app/features/results_tap/domain/repositories/results_history_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exam_app/features/results_tap/domain/usecases/save_results_history_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_results_history_use_case_test.mocks.dart';

@GenerateMocks([ResultsHistoryRepo])
void main() {
  ResultsHistoryRepo mockResultsHistoryRepoImpl = MockResultsHistoryRepo();
  SaveResultsHistoryUseCase saveResultsHistoryUseCase =
      SaveResultsHistoryUseCase(resultsHistoryRepo: mockResultsHistoryRepoImpl);

  test('saveResultsHistoryUseCase', () async {
    final examResult = ExamResultsCardEntity(
      examId: 'examId',
      finishDuration: 15,
      subject: "test",
      title: 'title',
      numberOfQuestions: 50,
      duration: 30,
      score: 30,
    );

    when(
      mockResultsHistoryRepoImpl.saveResult(examResult: examResult),
    ).thenAnswer((_) async => SuccessResponse<bool>(true));

    final response = await saveResultsHistoryUseCase(examResult: examResult);

    expect(response, isA<SuccessResponse<bool>>());
    expect((response as SuccessResponse<bool>).data, true);
  });
}
