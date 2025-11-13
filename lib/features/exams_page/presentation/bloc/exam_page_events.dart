abstract class ExamPageEvents {}

class PreviousQuestionEvent extends ExamPageEvents {}

class NextQuestionEvent extends ExamPageEvents {}

class GetExamQuestionsEvent extends ExamPageEvents {
  String? examId;
  GetExamQuestionsEvent({this.examId});
}

class SelectAnswer extends ExamPageEvents {
  final int questionIndex;
  final int answerIndex;
  SelectAnswer(this.questionIndex, this.answerIndex);
}
