abstract class ExamPageEvents {}

class PreviousQuestionEvent extends ExamPageEvents {}

class NextQuestionEvent extends ExamPageEvents {}

class GetExamQuestionsEvent extends ExamPageEvents {
  String? examId;
  GetExamQuestionsEvent({this.examId});
}
