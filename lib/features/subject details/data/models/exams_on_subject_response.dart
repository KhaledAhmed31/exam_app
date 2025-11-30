import 'package:json_annotation/json_annotation.dart';

import '../../../explore/data/models/get_all_subjects_response.dart';
part 'exams_on_subject_response.g.dart';

@JsonSerializable()
class ExamsOnSubjectResponse {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'metadata')
  Metadata? metadata;
  @JsonKey(name: 'exams')
  List<Exams>? exams;

  ExamsOnSubjectResponse({this.message, this.metadata, this.exams});

  factory ExamsOnSubjectResponse.fromJson(Map<String, dynamic> json) =>
      _$ExamsOnSubjectResponseFromJson(json);

  static List<ExamsOnSubjectResponse> fromList(
    List<Map<String, dynamic>> list,
  ) {
    return list.map(ExamsOnSubjectResponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$ExamsOnSubjectResponseToJson(this);
}

@JsonSerializable()
class Exams {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'duration')
  int? duration;
  @JsonKey(name: 'subject')
  String? subject;
  @JsonKey(name: 'numberOfQuestions')
  int? numberOfQuestions;
  @JsonKey(name: 'active')
  bool? active;
  @JsonKey(name: 'createdAt')
  String? createdAt;

  Exams({
    this.id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  factory Exams.fromJson(Map<String, dynamic> json) => _$ExamsFromJson(json);

  static List<Exams> fromList(List<Map<String, dynamic>> list) {
    return list.map(Exams.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$ExamsToJson(this);
}

