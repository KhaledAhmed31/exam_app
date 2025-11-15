import '../../../../../core/config/base_response/base_response.dart';
import '../../../../../core/config/error/error_handler.dart';
import '../api_client/login_api_client.dart';
import '../../data/datasources/login_remote_datasource.dart';
import '../../data/models/login_dto.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: LoginRemoteDatasource)
class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  LoginApiClient loginApiClient;
  LoginRemoteDatasourceImpl(this.loginApiClient);
  @override
  Future<BaseResponse<LoginDto>> login({
    String? email,
    String? password,
  }) async {
    try {
      LoginDto loginResponse = await loginApiClient.login({
        "email": email,
        "password": password,
      });
      return SuccessResponse<LoginDto>(loginResponse);
    } catch (e) {
      return ErrorResponse(error: ErrorHandler.handle(e));
    }
  }
}
