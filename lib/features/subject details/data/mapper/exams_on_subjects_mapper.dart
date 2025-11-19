import 'package:exam_app/features/subject%20details/data/models/exams_on_subject_response.dart';
import 'package:exam_app/features/subject%20details/domain/entities/exam_entity.dart';

extension ExamsOnSubjectsMapper on Exams {
  ExamEntity toEntity() => ExamEntity(
    id: id,
    title: title,
    active: active,
    numberOfQuestions: numberOfQuestions,
    subject: subject,
    duration: duration,
  );
}
