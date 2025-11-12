// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionDto _$QuestionDtoFromJson(Map<String, dynamic> json) => QuestionDto(
  answers: (json['answers'] as List<dynamic>?)
      ?.map((e) => AnswerDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  type: $enumDecodeNullable(_$TypeEnumMap, json['type']),
  id: json['_id'] as String?,
  question: json['question'] as String?,
  correct: $enumDecodeNullable(_$CorrectEnumMap, json['correct']),
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
      'type': _$TypeEnumMap[instance.type],
      '_id': instance.id,
      'question': instance.question,
      'correct': _$CorrectEnumMap[instance.correct],
      'subject': instance.subject,
      'exam': instance.exam,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$TypeEnumMap = {Type.SINGLE_CHOICE: 'single_choice'};

const _$CorrectEnumMap = {
  Correct.A1: 'A1',
  Correct.A2: 'A2',
  Correct.A3: 'A3',
  Correct.A4: 'A4',
};

AnswerDto _$AnswerDtoFromJson(Map<String, dynamic> json) => AnswerDto(
  answer: json['answer'] as String?,
  key: $enumDecodeNullable(_$CorrectEnumMap, json['key']),
);

Map<String, dynamic> _$AnswerDtoToJson(AnswerDto instance) => <String, dynamic>{
  'answer': instance.answer,
  'key': _$CorrectEnumMap[instance.key],
};

ExamDto _$ExamDtoFromJson(Map<String, dynamic> json) => ExamDto(
  id: $enumDecodeNullable(_$IdEnumMap, json['_id']),
  title: $enumDecodeNullable(_$TitleEnumMap, json['title']),
  duration: (json['duration'] as num?)?.toInt(),
  subject: $enumDecodeNullable(_$SubjectEnumMap, json['subject']),
  numberOfQuestions: (json['numberOfQuestions'] as num?)?.toInt(),
  active: json['active'] as bool?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ExamDtoToJson(ExamDto instance) => <String, dynamic>{
  '_id': _$IdEnumMap[instance.id],
  'title': _$TitleEnumMap[instance.title],
  'duration': instance.duration,
  'subject': _$SubjectEnumMap[instance.subject],
  'numberOfQuestions': instance.numberOfQuestions,
  'active': instance.active,
  'createdAt': instance.createdAt?.toIso8601String(),
};

const _$IdEnumMap = {
  Id.THE_670070_A830_A3_C3_C1944_A9_C63: '670070a830a3c3c1944a9c63',
};

const _$TitleEnumMap = {Title.HTML_QUIZ: 'HTML Quiz'};

const _$SubjectEnumMap = {
  Subject.THE_670037_F6728_C92_B7_FDF434_FC: '670037f6728c92b7fdf434fc',
};
