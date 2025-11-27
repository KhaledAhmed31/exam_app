// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionDto _$QuestionDtoFromJson(Map<String, dynamic> json) => QuestionDto(
  answers: (json['answers'] as List<dynamic>?)
      ?.map((e) => AnswerDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  type: json['type'] as String?,
  id: json['_id'] as String?,
  question: json['question'] as String?,
  correct: json['correct'] as String?,
  subject: json['subject'],
  exam: json['exam'] == null
      ? null
      : ExamDto.fromJson(json['exam'] as Map<String, dynamic>),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$QuestionDtoToJson(QuestionDto instance) =>
    <String, dynamic>{
      'answers': instance.answers,
      'type': instance.type,
      '_id': instance.id,
      'question': instance.question,
      'correct': instance.correct,
      'subject': instance.subject,
      'exam': instance.exam,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

AnswerDto _$AnswerDtoFromJson(Map<String, dynamic> json) =>
    AnswerDto(answer: json['answer'] as String?, key: json['key'] as String?);

Map<String, dynamic> _$AnswerDtoToJson(AnswerDto instance) => <String, dynamic>{
  'answer': instance.answer,
  'key': instance.key,
};

ExamDto _$ExamDtoFromJson(Map<String, dynamic> json) => ExamDto(
  id: json['_id'] as String?,
  title: json['title'] as String?,
  duration: (json['duration'] as num?)?.toInt(),
  subject: json['subject'] as String?,
  numberOfQuestions: (json['numberOfQuestions'] as num?)?.toInt(),
  active: json['active'] as bool?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ExamDtoToJson(ExamDto instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'duration': instance.duration,
  'subject': instance.subject,
  'numberOfQuestions': instance.numberOfQuestions,
  'active': instance.active,
  'createdAt': instance.createdAt?.toIso8601String(),
};
