import 'package:exam_app/features/exams_page/data/models/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_dto.g.dart';

@JsonSerializable()
class QuestionDto {
  @JsonKey(name: "answers")
  List<AnswerDto>? answers;
  @JsonKey(name: "type")
  Type? type;
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "question")
  String? question;
  @JsonKey(name: "correct")
  Correct? correct;
  @JsonKey(name: "subject")
  dynamic subject;
  @JsonKey(name: "exam")
  ExamDto? exam;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;

  QuestionDto({
    this.answers,
    this.type,
    this.id,
    this.question,
    this.correct,
    this.subject,
    this.exam,
    this.createdAt,
  });

  factory QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionDtoToJson(this);
}

@JsonSerializable()
class AnswerDto {
  @JsonKey(name: "answer")
  String? answer;
  @JsonKey(name: "key")
  Correct? key;

  AnswerDto({this.answer, this.key});

  factory AnswerDto.fromJson(Map<String, dynamic> json) =>
      _$AnswerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerDtoToJson(this);
}


@JsonSerializable()
class ExamDto {
  @JsonKey(name: "_id")
  Id? id;
  @JsonKey(name: "title")
  Title? title;
  @JsonKey(name: "duration")
  int? duration;
  @JsonKey(name: "subject")
  Subject? subject;
  @JsonKey(name: "numberOfQuestions")
  int? numberOfQuestions;
  @JsonKey(name: "active")
  bool? active;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;

  ExamDto({
    this.id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  factory ExamDto.fromJson(Map<String, dynamic> json) =>
      _$ExamDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExamDtoToJson(this);
}
