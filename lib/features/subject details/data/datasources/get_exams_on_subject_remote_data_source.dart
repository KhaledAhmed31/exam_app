import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/subject%20details/data/models/exams_on_subject_response.dart';

abstract class GetExamsOnSubjectRemoteDataSource {
  Future<BaseResponse<ExamsOnSubjectResponse>> getExamsOnSubjects({required String subjectId});
}