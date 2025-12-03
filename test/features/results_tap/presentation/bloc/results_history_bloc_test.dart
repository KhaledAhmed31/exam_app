import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';
import 'package:exam_app/features/results_tap/domain/usecases/get_results_history_use_case.dart';
import 'package:exam_app/features/results_tap/domain/usecases/save_results_history_use_case.dart';
import 'package:exam_app/features/results_tap/presentation/bloc/results_history_bloc.dart';
import 'package:exam_app/features/results_tap/presentation/bloc/results_history_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'results_history_bloc_test.mocks.dart';

@GenerateMocks([GetResultsHistoryUseCase, SaveResultsHistoryUseCase])
void main() {
  late ResultsHistoryBloc resultsHistoryBloc;
  late MockGetResultsHistoryUseCase getResultsHistoryUseCase;
  late MockSaveResultsHistoryUseCase saveResultsHistoryUseCase;
  setUpAll(() {
    provideDummy<BaseResponse<ExamResultsEntity>>(
      SuccessResponse<ExamResultsEntity>(ExamResultsEntity(results: {})),
    );
    getResultsHistoryUseCase = MockGetResultsHistoryUseCase();
    saveResultsHistoryUseCase = MockSaveResultsHistoryUseCase();
    resultsHistoryBloc = ResultsHistoryBloc(
      getResultsHistoryUseCase: getResultsHistoryUseCase,
      saveResultsHistoryUseCase: saveResultsHistoryUseCase,
    );
  });

  test(
    'ResultsHistoryBloc initial state should be ResultsHistoryState',
    () async {
      when(getResultsHistoryUseCase.call()).thenAnswer(
        (_) async =>
            SuccessResponse<ExamResultsEntity>(ExamResultsEntity(results: {})),
      );
      when(
        saveResultsHistoryUseCase.call(
          examResult: ExamResultsCardEntity(
            duration: 15,
            examId: "kaj",
            score: 10,
            subject: "test",
            title: "test",
            numberOfQuestions: 10,
            finishDuration: 12,
          ),
        ),
      ).thenAnswer((_) async => SuccessResponse<bool>(true));
      final state = resultsHistoryBloc.state;
      expect(state, isA<ResultsHistoryState>());
    },
  );
}
