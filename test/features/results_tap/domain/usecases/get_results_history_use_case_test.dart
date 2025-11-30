import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';
import 'package:flutter_test/flutter_test.dart'; 
import 'package:exam_app/features/results_tap/domain/usecases/get_results_history_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_results_history_use_case_test.mocks.dart';

@GenerateMocks([GetResultsHistoryUseCase])
void main() {
  GetResultsHistoryUseCase mockGetResultsHistoryUseCase =
      MockGetResultsHistoryUseCase();
	test(
		'Should ',
		() async {
      when(mockGetResultsHistoryUseCase.call()).thenAnswer(
        (_) async => SuccessResponse(
          ExamResultsEntity(results: {}),
        ),
      );
      final response = await mockGetResultsHistoryUseCase.call();
      expect(response, isA<SuccessResponse<ExamResultsEntity>>());
		},
	);
}
