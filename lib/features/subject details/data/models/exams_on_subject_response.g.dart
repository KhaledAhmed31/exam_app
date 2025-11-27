// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exams_on_subject_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamsOnSubjectResponse _$ExamsOnSubjectResponseFromJson(
  Map<String, dynamic> json,
) => ExamsOnSubjectResponse(
  message: json['message'] as String?,
  metadata: json['metadata'] == null
      ? null
      : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
  exams: (json['exams'] as List<dynamic>?)
      ?.map((e) => Exams.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ExamsOnSubjectResponseToJson(
  ExamsOnSubjectResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'exams': instance.exams,
};

Exams _$ExamsFromJson(Map<String, dynamic> json) => Exams(
  id: json['_id'] as String?,
  title: json['title'] as String?,
  duration: (json['duration'] as num?)?.toInt(),
  subject: json['subject'] as String?,
  numberOfQuestions: (json['numberOfQuestions'] as num?)?.toInt(),
  active: json['active'] as bool?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$ExamsToJson(Exams instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'duration': instance.duration,
  'subject': instance.subject,
  'numberOfQuestions': instance.numberOfQuestions,
  'active': instance.active,
  'createdAt': instance.createdAt,
};
