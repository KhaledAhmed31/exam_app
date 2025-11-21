class QuestionModel {
  String? type;
  String? id;
  String? question;
  ExamModel? exam;
  String? correct;
  List<AnswerModel>? answers;

  QuestionModel({
    this.type,
    this.id,
    this.exam,
    this.question,
    this.answers,
    this.correct,
  });
}

class ExamModel {
  String? id;
  String? title;
  int? numberOfQuestions;
  String? subject;
  int? duration;
  ExamModel({this.id, this.title, this.numberOfQuestions, this.subject, this.duration});
}

class AnswerModel {
  String? answer;
  String? key;
  AnswerModel({this.answer, this.key});
}
