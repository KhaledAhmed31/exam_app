import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/config/api/api_const.dart';
import '../../data/models/login_dto.dart';
import '../../data/models/send_reset_code_response.dart';
import '../../data/models/verify_reset_code_response.dart';
import '../../data/models/reset_password_response.dart';

part 'auth_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiConsts.baseUrl)
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio) = _AuthApiClient;

  @POST(ApiConsts.loginEndPoint)
  Future<LoginDto> login(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConsts.forgetPasswordEndPoint)
  Future<SendResetCodeResponse> sendResetCode(
    @Body() Map<String, dynamic> body,
  );

  @POST(ApiConsts.verifyResetCodeEndPoint)
  Future<VerifyResetCodeResponse> verifyResetCode(
    @Body() Map<String, dynamic> body,
  );

  @PUT(ApiConsts.resetPasswordEndPoint)
  Future<ResetPasswordResponse> resetPassword(
    @Body() Map<String, dynamic> body,
  );
}
