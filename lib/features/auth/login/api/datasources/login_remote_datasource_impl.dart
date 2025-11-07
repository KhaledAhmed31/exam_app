import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/login/api/api_client/login_api_client.dart';
import 'package:exam_app/features/auth/login/data/datasources/login_remote_datasource.dart';
import 'package:exam_app/features/auth/login/data/models/login_dto.dart';
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
      return ErrorResponse<LoginDto>(e.toString());
    }
  }
}
