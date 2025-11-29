
import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/ui_manager/colors/app_colors.dart';
import 'package:exam_app/core/ui_manager/fonts/font_sizes_manager.dart';
import 'package:exam_app/core/ui_manager/fonts/font_style_manager.dart';
import 'package:exam_app/features/results_tap/presentation/bloc/results_history_bloc.dart';
import 'package:exam_app/features/results_tap/presentation/bloc/results_history_events.dart';
import 'package:exam_app/features/results_tap/presentation/bloc/results_history_states.dart';
import 'package:exam_app/features/results_tap/presentation/widgets/exam_result_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: BlocProvider.value(
        value: getIt<ResultsHistoryBloc>()..add(LoadResultsHistoryEvent()),
        child: BlocBuilder<ResultsHistoryBloc, ResultsHistoryState>(
          builder: (context, state) {
            final results = state.resultsHistoryList?.results ?? {};
            if (state.isLoading!) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.errorMessage!.isNotEmpty) {
              return Center(child: Text(state.errorMessage!));
            } else if (results.isEmpty) {
              return const Center(child: Text('No results found.'));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        results.keys.elementAt(index),
                        style: FontStyleManager.interMedium(
                          color: AppColors.blackBase,
                          fontSize: FontSizesManager.s18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...results[results.keys.elementAt(index)]!.map(
                        (exam) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ExamResultCard(exam: exam),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
