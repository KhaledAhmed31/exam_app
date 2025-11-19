
class ExamsOnSubjectEntity {
  final List<ExamEntity> exams;
  final String subject;

  const ExamsOnSubjectEntity({
     this.exams = const [],
     this.subject = '',
  });
}
class ExamEntity {
  String? id;
  String? title;
  int? duration;
  String? subject;
  int? numberOfQuestions;
  bool? active;

  ExamEntity({
    this.id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
  });

}
