class ExamResultsEntity {
  final Map<String, List<ExamResultsCardEntity>> results;

  ExamResultsEntity({required this.results});
}

class ExamResultsCardEntity {
  final String subject;
  final String title;
  final int numberOfQuestions;
  final int duration;
  final int score;

  ExamResultsCardEntity({
    required this.subject,
    required this.title,
    required this.numberOfQuestions,
    required this.duration,
    required this.score,
  });
}
