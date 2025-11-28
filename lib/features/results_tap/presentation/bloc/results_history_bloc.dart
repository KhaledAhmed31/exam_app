
import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';
import 'package:exam_app/features/results_tap/domain/usecases/get_results_history_use_case.dart';
import 'package:exam_app/features/results_tap/domain/usecases/save_results_history_use_case.dart';
import 'package:exam_app/features/results_tap/presentation/bloc/results_history_events.dart';
import 'package:exam_app/features/results_tap/presentation/bloc/results_history_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResultsHistoryBloc
    extends Bloc<ResultsHistoryEvents, ResultsHistoryState> {
  final GetResultsHistoryUseCase getResultsHistoryUseCase;
  final SaveResultsHistoryUseCase saveResultsHistoryUseCase;

  ResultsHistoryBloc({
    required this.getResultsHistoryUseCase,
    required this.saveResultsHistoryUseCase,
  }) : super(ResultsHistoryState()) {
    on<LoadResultsHistoryEvent>(_getResultsHistory);
    on<SaveExamResultEvent>(_saveExamResult);
    add(LoadResultsHistoryEvent());
  }

  Future<void> _saveExamResult(
    SaveExamResultEvent event,
    Emitter<ResultsHistoryState> emit,
  ) async {
    final response = await saveResultsHistoryUseCase(
      examResult: event.examResult,
    );
    switch (response) {
      case ErrorResponse<bool, Failure>():
        emit(state.copywith(errorMessage: response.error.message));
      default:
        emit(
          state.copywith(
            isLoading: false,
            errorMessage: 'Unknown error occurred.',
          ),
        );
    }
  }

  Future<void> _getResultsHistory(
    LoadResultsHistoryEvent event,
    Emitter<ResultsHistoryState> emit,
  ) async {
    emit(state.copywith(isLoading: true, errorMessage: ''));
    final response = await getResultsHistoryUseCase();
    switch (response) {
      case SuccessResponse<ExamResultsEntity>():
        emit(
          state.copywith(isLoading: false, resultsHistoryList: response.data),
        );

      case ErrorResponse<ExamResultsEntity, Failure>():
        emit(
          state.copywith(
            isLoading: false,
            errorMessage: response.error.message,
          ),
        );
      default:
        emit(
          state.copywith(
            isLoading: false,
            errorMessage: 'Unknown error occurred.',
          ),
        );
    }
  }
}
