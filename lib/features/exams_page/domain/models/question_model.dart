import 'package:exam_app/features/exams_page/data/models/enums.dart';

class QuestionModel {
  Type? type;
  String? id;
  String? question;
  ExamModel? exam;
  Correct? correct;
  List<AnswerModel>? answers;

  QuestionModel({this.type, this.id, this.exam, this.question, this.answers, this.correct});
}

class ExamModel {
  Id? id;
  Title? title;
  int? numberOfQuestions;
  Subject? subject;
  ExamModel({this.id, this.title, this.numberOfQuestions, this.subject});
}

class AnswerModel {
  String? answer;
  Correct? key;
  AnswerModel({this.answer, this.key});
}
