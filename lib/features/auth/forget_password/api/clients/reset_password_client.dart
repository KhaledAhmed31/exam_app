import 'package:dio/dio.dart';
import '../../../../../core/config/api/api_const.dart';
import '../../data/models/reset_password_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'reset_password_client.g.dart';
@RestApi()
@lazySingleton
abstract class ResetPasswordClient {
  @factoryMethod
  factory ResetPasswordClient(Dio dio) => _ResetPasswordClient(dio);

  @PUT(ApiConsts.resetPasswordEndPoint)
  Future<ResetPasswordResponse> resetPassword(@Body() Map<String, dynamic> body);
}
