
import 'package:json_annotation/json_annotation.dart';
part 'get_all_subjects_response.g.dart';

@JsonSerializable()
class GetAllSubjectsResponse {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'metadata')
  Metadata? metadata;
  @JsonKey(name: 'subjects')
  List<Subjects>? subjects;

  GetAllSubjectsResponse({this.message, this.metadata, this.subjects});

  factory GetAllSubjectsResponse.fromJson(Map<String, dynamic> json) => _$GetAllSubjectsResponseFromJson(json);

  static List<GetAllSubjectsResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(GetAllSubjectsResponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$GetAllSubjectsResponseToJson(this);
}

@JsonSerializable()
class Subjects {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'icon')
  String? icon;
  @JsonKey(name: 'createdAt')
  String? createdAt;

  Subjects({this.id, this.name, this.icon, this.createdAt});

  factory Subjects.fromJson(Map<String, dynamic> json) => _$SubjectsFromJson(json);

  static List<Subjects> fromList(List<Map<String, dynamic>> list) {
    return list.map(Subjects.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$SubjectsToJson(this);
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: 'currentPage')
  int? currentPage;
  @JsonKey(name: 'numberOfPages')
  int? numberOfPages;
  @JsonKey(name: 'limit')
  int? limit;

  Metadata({this.currentPage, this.numberOfPages, this.limit});

  factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);

  static List<Metadata> fromList(List<Map<String, dynamic>> list) {
    return list.map(Metadata.fromJson).toList();
  }

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}