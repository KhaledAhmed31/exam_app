import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/results_tap/data/datasources/exam_results_data_source.dart';
import 'package:exam_app/features/results_tap/data/models/exam_result_model.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exam_app/features/results_tap/data/repositories/results_history_repo_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'results_history_repo_impl_test.mocks.dart';

@GenerateMocks([ExamResultsDataSource])
void main() {
  MockExamResultsDataSource mockExamResultsDataSource =
      MockExamResultsDataSource();
  ResultsHistoryRepoImpl resultsHistoryRepoImpl = ResultsHistoryRepoImpl(
    mockExamResultsDataSource,
  );
  test('resultsHistoryRepoImpl ', () async {
    when(mockExamResultsDataSource.getExamResults()).thenAnswer(
      (_) async => SuccessResponse(
        ExamResultsModel(
          results: {
            '1': [
              ExamResultCardModel(
                examId: '012',
                finishDuration: 15,
                subject: "test",
                title: 'title',
                numberOfQuestions: 50,
                duration: 30,
                score: 30,
              ),
            ],
          },
        ),
      ),
    );
    final response = await resultsHistoryRepoImpl.getResultsHistory();
    expect(response, isA<SuccessResponse<ExamResultsEntity>>());
    expect(
      (response as SuccessResponse<ExamResultsEntity>).data.results!.keys.first,
      "1",
    );
    expect(
      (response).data.results!.values.first.first.examId,
      "012",
    );
  });
}
