class ExamResultsEntity {
  final Map<String, List<ExamResultsCardEntity>>? results;

  const ExamResultsEntity({ this.results});
}

class ExamResultsCardEntity {
  final String subject;
  final String title;
  final String examId;
  final int numberOfQuestions;
  final int duration;
  final int score;

 const ExamResultsCardEntity({
    required this.subject,
    required this.title,
    required this.numberOfQuestions,
    required this.duration,
    required this.score, required this.examId,
  });
}
