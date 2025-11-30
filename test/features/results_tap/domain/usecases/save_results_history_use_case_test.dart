import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/results_tap/data/repositories/results_history_repo_impl.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exam_app/features/results_tap/domain/usecases/save_results_history_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../data/repositories/results_history_repo_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SaveResultsHistoryUseCase>(),
  MockSpec<ResultsHistoryRepoImpl>(),
])
void main() {
  MockResultsHistoryRepoImpl mockResultsHistoryRepoImpl =
      MockResultsHistoryRepoImpl();
  SaveResultsHistoryUseCase mockSaveResultsHistoryUseCase =
      SaveResultsHistoryUseCase(resultsHistoryRepo: mockResultsHistoryRepoImpl);

  test('Should ', () async {
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
      mockSaveResultsHistoryUseCase(examResult: examResult),
    ).thenAnswer((_) async => SuccessResponse<bool>(true));

    final response = await mockSaveResultsHistoryUseCase(
      examResult: examResult,
    );

    expect(response, isA<SuccessResponse<bool>>());
  });
}
