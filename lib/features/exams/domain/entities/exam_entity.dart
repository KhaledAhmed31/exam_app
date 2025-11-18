class ExamEntity {
  final String id;
  final String subjectId;
  final String title; // e.g., English, Spanish
  final String level; // e.g., High level
  final int durationMinutes;
  final int questionsCount;
  final double minScore;
  final double maxScore;

  ExamEntity({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.level,
    required this.durationMinutes,
    required this.questionsCount,
    required this.minScore,
    required this.maxScore,
  });
}