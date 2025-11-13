import 'package:dio/dio.dart';
import 'package:exam_app/core/config/api/api_const.dart';
import 'package:exam_app/features/exams_page/data/models/exam_questions_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'exam_questions_api_client.g.dart';

@singleton
@RestApi(baseUrl: ApiConsts.baseUrl)
abstract class ExamQuestionsApiClient {
  @factoryMethod
  factory ExamQuestionsApiClient(Dio dio) = _ExamQuestionsApiClient;

  @GET(ApiConsts.getAllQuestionsOnExamEndPoint)
  Future<ExamQuestionsResponse> getExamQuestions(
    @Header('token') String token,
    @Query('exam') String examId,
  );
}
