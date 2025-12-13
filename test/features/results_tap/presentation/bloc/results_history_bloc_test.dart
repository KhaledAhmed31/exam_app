import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';
import 'package:exam_app/features/results_tap/domain/usecases/get_results_history_use_case.dart';
import 'package:exam_app/features/results_tap/domain/usecases/save_results_history_use_case.dart';
import 'package:exam_app/features/results_tap/presentation/bloc/results_history_bloc.dart';
import 'package:exam_app/features/results_tap/presentation/bloc/results_history_events.dart';
import 'package:exam_app/features/results_tap/presentation/bloc/results_history_states.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'results_history_bloc_test.mocks.dart';

@GenerateMocks([GetResultsHistoryUseCase, SaveResultsHistoryUseCase])
void main() {
  late MockGetResultsHistoryUseCase getResultsHistoryUseCase;
  late MockSaveResultsHistoryUseCase saveResultsHistoryUseCase;
  setUpAll(() {
    getResultsHistoryUseCase = MockGetResultsHistoryUseCase();
    saveResultsHistoryUseCase = MockSaveResultsHistoryUseCase();
  });
  group("Results bloc test", () {
    blocTest<ResultsHistoryBloc, ResultsHistoryState>(
      "get results history success",
      build: () {
        when(getResultsHistoryUseCase.call()).thenAnswer(
          (_) async => SuccessResponse(ExamResultsEntity(results: {})),
        );
        return ResultsHistoryBloc(
          getResultsHistoryUseCase: getResultsHistoryUseCase,
          saveResultsHistoryUseCase: saveResultsHistoryUseCase,
        );
      },
      skip: 2, // Skip the state emitted by the constructor's add event
      act: (bloc) => bloc.add(LoadResultsHistoryEvent()),
      expect: () => [
        isA<ResultsHistoryState>().having(
          (state) => state.isLoading,
          "isLoading",
          true,
        ),
        isA<ResultsHistoryState>().having(
          (state) => state.isLoading,
          "isLoading",
          false,
        ),
      ],
    );

    blocTest<ResultsHistoryBloc, ResultsHistoryState>(
      "get result history failure",
      build: () {
        when(
          getResultsHistoryUseCase.call(),
        ).thenAnswer((_) async => ErrorResponse(error: Failure));
        return ResultsHistoryBloc(
          getResultsHistoryUseCase: getResultsHistoryUseCase,
          saveResultsHistoryUseCase: saveResultsHistoryUseCase,
        );
      },
      skip: 2, // Skip the state emitted by the constructor's add event
      act: (bloc) => bloc.add(LoadResultsHistoryEvent()),
      expect: () => [
        isA<ResultsHistoryState>().having(
          (state) => state.isLoading,
          "isLoading",
          true,
        ),
        isA<ResultsHistoryState>().having(
          (state) => state.errorMessage,
          "errorMessage",
          "Unknown error occurred.",
        ),
      ],
    );

    blocTest<ResultsHistoryBloc, ResultsHistoryState>(
      "save result history success",
      build: () {
        when(
          saveResultsHistoryUseCase(
            examResult: argThat(
              isA<ExamResultsCardEntity>(),
              named: "examResult",
            ),
          ),
        ).thenAnswer((_) async => SuccessResponse<bool>(true));
        return ResultsHistoryBloc(
          getResultsHistoryUseCase: getResultsHistoryUseCase,
          saveResultsHistoryUseCase: saveResultsHistoryUseCase,
        );
      },
      skip: 2, // Skip the state emitted by the constructor's add event
      act: (bloc) => bloc.add(
        SaveExamResultEvent(
          examResult: ExamResultsCardEntity(
            duration: 30,
            examId: 'examId',
            finishDuration: 15,
            numberOfQuestions: 50,
            score: 30,
            subject: "test",
            title: 'title',
          ),
        ),
      ),
      expect: () => [isA<ResultsHistoryState>()],
    );

    blocTest<ResultsHistoryBloc, ResultsHistoryState>(
      "save result history failure",
      build: () {
        when(
          getResultsHistoryUseCase.call(),
        ).thenAnswer(
          (_) async => SuccessResponse(ExamResultsEntity(results: {})),
        );
        when(
          saveResultsHistoryUseCase(
            examResult: argThat(
              isA<ExamResultsCardEntity>(),
              named: "examResult",
            ),
          ),
        ).thenAnswer((_) async => ErrorResponse(error: Failure));
        return ResultsHistoryBloc(
          getResultsHistoryUseCase: getResultsHistoryUseCase,
          saveResultsHistoryUseCase: saveResultsHistoryUseCase,
        );
      },
      skip: 2, // Skip the state emitted by the constructor's add event
      act: (bloc) => bloc.add(
        SaveExamResultEvent(
          examResult: ExamResultsCardEntity(
            duration: 30,
            examId: 'examId',
            finishDuration: 15,
            numberOfQuestions: 50,
            score: 30,
            subject: "test",
            title: 'title',
          ),
        ),
      ),
      expect: () => [
        isA<ResultsHistoryState>().having(
          (state) => state.errorMessage,
          "errorMessage",
          "Unknown error occurred.",
        ),
      ],
    );
  });
}