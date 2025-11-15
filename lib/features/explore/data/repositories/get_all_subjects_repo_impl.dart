import 'package:injectable/injectable.dart';

import '../../../../core/config/base_response/base_response.dart';
import '../../../../core/config/error/error_handler.dart';
import '../../domain/entities/subject_entity.dart';
import '../../domain/repositories/get_all_subjects_repo.dart';
import '../datasources/get_all_subjects_data_source.dart';
import '../mapper/get_all_subjects_mapper.dart';
import '../models/get_all_subjects_response.dart';

@LazySingleton(as: GetAllSubjectsRepo)
class GetAllSubjectsRepoImpl implements GetAllSubjectsRepo {
  final GetAllSubjectsDataSource _getAllSubjectsDataSource;

  GetAllSubjectsRepoImpl(this._getAllSubjectsDataSource);
  @override
  Future<BaseResponse<List<SubjectEntity>>> getAllSubjects() async {
    final response = await _getAllSubjectsDataSource.getAllSubjects();
    switch (response) {
      case SuccessResponse<GetAllSubjectsResponse>():
        return SuccessResponse<List<SubjectEntity>>(response.data.subjects?.map((e) => e.toDomain()).toList() ?? []);
      case ErrorResponse<GetAllSubjectsResponse, ErrorHandler>():
        return ErrorResponse<List<SubjectEntity>, Failure>(error: response.error.failure);
      default:
        return SuccessResponse<List<SubjectEntity>>([]);
    }
  }
}
