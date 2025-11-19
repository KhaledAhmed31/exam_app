import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/subject%20details/data/datasources/get_exams_on_subject_remote_data_source.dart';
import 'package:exam_app/features/subject%20details/data/mapper/exams_on_subjects_mapper.dart';
import 'package:exam_app/features/subject%20details/data/models/exams_on_subject_response.dart';
import 'package:exam_app/features/subject%20details/domain/entities/exam_entity.dart';
import 'package:exam_app/features/subject%20details/domain/repositories/get_exams_on_subject_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GetExamsOnSubjectRepo)
class GetExamsOnSubjectRepoImpl implements GetExamsOnSubjectRepo {
  final GetExamsOnSubjectRemoteDataSource _getExamsOnSubjectDataSource;

  GetExamsOnSubjectRepoImpl(this._getExamsOnSubjectDataSource);
  @override
  Future<BaseResponse<ExamsOnSubjectEntity>> getExamsOnSubject({
    required String subjectId,
    required String subjectName,
  }) async {
    BaseResponse<ExamsOnSubjectResponse> response =
        await _getExamsOnSubjectDataSource.getExamsOnSubjects(
          subjectId: subjectId,
        );
    switch (response) {
      case SuccessResponse<ExamsOnSubjectResponse>():
        return SuccessResponse<ExamsOnSubjectEntity>(
          ExamsOnSubjectEntity(
            exams: response.data.exams?.map((e) => e.toEntity()).toList() ?? [],
            subject: subjectName,
          ),
        );
      case ErrorResponse<ExamsOnSubjectResponse, ErrorHandler>():
        return ErrorResponse<ExamsOnSubjectEntity, Failure>(
          error: response.error.failure,
        );
      default:
        return SuccessResponse( ExamsOnSubjectEntity(exams: [],subject: subjectName));
    }
  }
}
