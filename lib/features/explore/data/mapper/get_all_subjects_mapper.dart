import '../models/get_all_subjects_response.dart';
import '../../domain/entities/subject_entity.dart';

extension GetAllSubjectsMapper on Subjects {
  SubjectEntity toDomain() =>
      SubjectEntity(id: id ?? "", name: name ?? "", icon: icon ?? "");
}
