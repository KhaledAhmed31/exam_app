class ExamEntity {
  final String id;
  final String title;
  final int duration;
  final int numberOfQuestions;
  final String? subject;
  final bool? active;

  // Static defaults for fields not in API
  final String level;
  final double minScore;
  final double maxScore;

  ExamEntity({
    required this.id,
    required this.title,
    required this.duration,
    required this.numberOfQuestions,
    this.subject,
    this.active,
    this.level = 'High level',
    this.minScore = 1.00,
    this.maxScore = 6.00,
  });

  factory ExamEntity.fromApiResponse({
    required String id,
    required String title,
    required int duration,
    required int numberOfQuestions,
    String? subject,
    bool? active,
  }) {
    return ExamEntity(
      id: id,
      title: title,
      duration: duration,
      numberOfQuestions: numberOfQuestions,
      subject: subject,
      active: active,
      // static defaults values
      level: 'High level',
      minScore: 1.00,
      maxScore: 6.00,
    );
  }
}
