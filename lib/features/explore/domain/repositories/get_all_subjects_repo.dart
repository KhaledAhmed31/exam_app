import '../../../../core/config/base_response/base_response.dart';
import '../entities/subject_entity.dart';

abstract class GetAllSubjectsRepo {
  Future<BaseResponse<List<SubjectEntity>>> getAllSubjects();
}