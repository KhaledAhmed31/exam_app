import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/subject%20details/api/clients/get_exams_on_subjects_client.dart';
import 'package:exam_app/features/subject%20details/data/datasources/get_exams_on_subject_remote_data_source.dart';
import 'package:exam_app/features/subject%20details/data/models/exams_on_subject_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GetExamsOnSubjectRemoteDataSource)
class GetExamsOnSubjectDataSourceImp implements GetExamsOnSubjectRemoteDataSource {
  final GetExamsOnSubjectsClient _client;

  GetExamsOnSubjectDataSourceImp(this._client);
  @override
  Future<BaseResponse<ExamsOnSubjectResponse>> getExamsOnSubjects({required String subjectId})async {
    try{
      return SuccessResponse<ExamsOnSubjectResponse>(await _client.getExamsOnSubjects(subjectId: subjectId));

    }catch(e){
      return ErrorResponse(error: ErrorHandler.handle(e));
    }
  }
}