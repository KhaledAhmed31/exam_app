import 'package:exam_app/features/exams_page/data/models/question_dto.dart';
import 'package:exam_app/features/exams_page/domain/models/question_model.dart';

extension QuestionDtoMapper on QuestionDto {
  QuestionModel toQuestionsModel() {
    return QuestionModel(
      type: type,
      id: id,
      exam: exam?.toExamModel(),
      answers: answers?.map((answer) => answer.toAnswerModel()).toList(),
    );
  }
}

extension ExamDtoMapper on ExamDto {
  ExamModel toExamModel() {
    return ExamModel(
      id: id,
      subject: subject,
      title: title,
      numberOfQuestions: numberOfQuestions,
    );
  }
}

extension AnswerDtoMapper on AnswerDto {
  AnswerModel toAnswerModel() {
    return AnswerModel(answer: answer, key: key);
  }
}
