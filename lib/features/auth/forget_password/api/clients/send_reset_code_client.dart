import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/config/api/api_const.dart';
import '../../data/models/send_reset_code_response.dart';

part 'send_reset_code_client.g.dart';

@lazySingleton
@RestApi()
abstract class SendResetCodeClient {
  @factoryMethod
  factory SendResetCodeClient(Dio dio) = _SendResetCodeClient;

  @POST(ApiConsts.forgetPasswordEndPoint)
  Future<SendResetCodeResponse> sendRestCode(@Body() Map<String, dynamic> body);
}
