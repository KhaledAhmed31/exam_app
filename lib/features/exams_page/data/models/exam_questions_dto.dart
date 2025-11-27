import 'package:exam_app/features/exams_page/data/models/question_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'exam_questions_dto.g.dart';

ExamQuestionsResponse examQuestionsDtoFromJson(String str) =>
    ExamQuestionsResponse.fromJson(json.decode(str));

String examQuestionsDtoToJson(ExamQuestionsResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class ExamQuestionsResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "questions")
  List<QuestionDto>? questions;

  ExamQuestionsResponse({this.message, this.questions});

  factory ExamQuestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$ExamQuestionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExamQuestionsResponseToJson(this);
}
