import 'package:dio/dio.dart';
import 'package:exam_app/core/config/api/api_const.dart';
import 'package:exam_app/features/subject%20details/data/models/exams_on_subject_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'get_exams_on_subjects_client.g.dart';

@lazySingleton
@RestApi()
abstract class GetExamsOnSubjectsClient {
  @factoryMethod
  factory GetExamsOnSubjectsClient(Dio dio) = _GetExamsOnSubjectsClient;

  @GET(ApiConsts.getExamsOnSubjectEndPoint)
  Future<ExamsOnSubjectResponse> getExamsOnSubjects({
    @Query('subject') required String subjectId,
  });
}
