import 'package:dio/dio.dart';
import '../../../../../core/config/api/api_const.dart';
import '../../data/models/login_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'login_api_client.g.dart';

@singleton
@RestApi(baseUrl: ApiConsts.baseUrl)
abstract class LoginApiClient {
  @factoryMethod
  factory LoginApiClient(Dio dio) = _LoginApiClient;

  @POST(ApiConsts.loginEndPoint)
  Future<LoginDto> login(@Body() Map<String, dynamic> loginBody);
}
