abstract class ExamPageEvents {}

class PreviousQuestionEvent extends ExamPageEvents {}

class NextQuestionEvent extends ExamPageEvents {
  final String? selectedAnswerKey;
  NextQuestionEvent({this.selectedAnswerKey});
}

class GetExamQuestionsEvent extends ExamPageEvents {
  String? examId;
  GetExamQuestionsEvent({this.examId});
}

class SelectAnswer extends ExamPageEvents {
  final int questionIndex;
  final String answerKey;
  SelectAnswer(this.questionIndex, this.answerKey);
}

class FinishExamEvent extends ExamPageEvents {}
