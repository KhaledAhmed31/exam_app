import '../../../../core/config/base_response/base_response.dart';
import '../models/get_all_subjects_response.dart';

abstract class GetAllSubjectsDataSource {
  Future<BaseResponse<GetAllSubjectsResponse>> getAllSubjects();
}
