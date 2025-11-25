import 'package:dio/dio.dart';
import '../../../../core/config/api/api_const.dart';
import '../../data/models/get_all_subjects_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'get_all_subject_client.g.dart';
@lazySingleton
@RestApi()
abstract class GetAllSubjectClient {
  @factoryMethod
  factory GetAllSubjectClient(Dio dio) => _GetAllSubjectClient(dio);
  @GET(ApiConsts.getCategoriesEndPoint)
  Future<GetAllSubjectsResponse> getAllSubjects();
}