import 'package:dio/dio.dart';
import '../../../../../core/config/api/api_const.dart';
import '../../data/models/verify_reset_code_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'verify_reset_code_client.g.dart';
@lazySingleton
@RestApi()
abstract class VerifyResetCodeClient {
  @factoryMethod
  factory VerifyResetCodeClient(Dio dio) => _VerifyResetCodeClient(dio);

  @POST(ApiConsts.verifyResetCodeEndPoint)
  Future<VerifyResetCodeResponse> verifyResetCode(
    @Body()Map<String, dynamic> body,
  );
}
