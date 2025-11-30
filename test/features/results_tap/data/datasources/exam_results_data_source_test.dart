import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/results_tap/data/models/exam_result_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exam_app/features/results_tap/data/datasources/exam_results_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'exam_results_data_source_test.mocks.dart';

@GenerateMocks([ExamResultsDataSource])
void main() {
  ExamResultsDataSource? mockExamResultsDataSource =
      MockExamResultsDataSource();

  test('Should ', () async {
    when(mockExamResultsDataSource.getExamResults()).thenAnswer(
      (_) async =>
          SuccessResponse<ExamResultsModel>(ExamResultsModel(results: {})),
    );

    final response = await mockExamResultsDataSource.getExamResults();
    expect(response, isA<SuccessResponse<ExamResultsModel>>());
  });
}
