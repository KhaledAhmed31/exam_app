import '../../domain/entities/exam_entity.dart';

List<ExamEntity> mockExamsForSubject(String subjectId) {
  return [
    ExamEntity(
      id: 'en-1',
      subjectId: subjectId,
      title: 'English',
      level: 'High level',
      durationMinutes: 30,
      questionsCount: 20,
      minScore: 1.0,
      maxScore: 6.0,
    ),
    ExamEntity(
      id: 'en-2',
      subjectId: subjectId,
      title: 'English',
      level: 'Medium level',
      durationMinutes: 30,
      questionsCount: 20,
      minScore: 1.0,
      maxScore: 6.0,
    ),
    ExamEntity(
      id: 'es-1',
      subjectId: subjectId,
      title: 'Spanish',
      level: 'High level',
      durationMinutes: 30,
      questionsCount: 20,
      minScore: 1.0,
      maxScore: 6.0,
    ),
    ExamEntity(
      id: 'es-2',
      subjectId: subjectId,
      title: 'Spanish',
      level: 'Medium level',
      durationMinutes: 30,
      questionsCount: 20,
      minScore: 1.0,
      maxScore: 6.0,
    ),
  ];
}
