import 'package:equatable/equatable.dart';
import 'package:exam_app/features/results_tap/domain/entities/exam_results_entity.dart';

class ResultsHistoryState extends Equatable {
  final bool? isLoading;
  final String? errorMessage;
  final ExamResultsEntity? resultsHistoryList;
  const ResultsHistoryState({
    this.isLoading = false,
    this.errorMessage = '',
    this.resultsHistoryList = const ExamResultsEntity(),
  });
  @override
  List<Object?> get props => [isLoading, errorMessage, resultsHistoryList];

  ResultsHistoryState copywith({
    bool? isLoading,
    String? errorMessage,
    ExamResultsEntity? resultsHistoryList,
  }) {
    return ResultsHistoryState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      resultsHistoryList: resultsHistoryList ?? this.resultsHistoryList,
    );
  }
}
