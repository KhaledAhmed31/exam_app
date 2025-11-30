import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';
import 'package:flutter_test/flutter_test.dart'; 
import 'package:exam_app/features/results_tap/data/repositories/results_history_repo_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'results_history_repo_impl_test.mocks.dart';

@GenerateMocks([ResultsHistoryRepoImpl])
void main() {
  ResultsHistoryRepoImpl mockResultsHistoryRepoImpl =
      MockResultsHistoryRepoImpl();
	test(
		'Should ',
		() async {
      when(mockResultsHistoryRepoImpl.getResultsHistory()).thenAnswer(
        (_) async => SuccessResponse(
          ExamResultsEntity(results: {}),
        ),
      );
      final response = await mockResultsHistoryRepoImpl.getResultsHistory();
      expect(response, isA<SuccessResponse<ExamResultsEntity>>());
		},
	);
}
