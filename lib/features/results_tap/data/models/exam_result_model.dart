class ExamResultsModel {
  final Map<String, List<ExamResultCardModel>> results;
  ExamResultsModel({required this.results});
}

class ExamResultCardModel {
  final String subject;
  final String examId;
  final String title;
  final int numberOfQuestions;
  final int duration;
  final int finishDuration;
  final int score;

  ExamResultCardModel({
    required this.subject,
    required this.title,
    required this.numberOfQuestions,
    required this.duration,
    required this.score, required this.examId, required this.finishDuration,
  });
}
