import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/auth/login/data/datasources/login_local_datasource.dart';
import 'package:exam_app/features/auth/login/data/datasources/login_remote_datasource.dart';
import 'package:exam_app/features/auth/login/data/mappers/login_dto_mapper.dart';
import 'package:exam_app/features/auth/login/data/models/login_dto.dart';
import 'package:exam_app/features/auth/login/domain/models/login_model.dart';
import 'package:exam_app/features/auth/login/domain/repos/login_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Injectable(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {
  final logger = Logger();
  LoginRemoteDatasource loginRemoteDatasource;
  LoginLocalDatasource loginLocalDatasource;
  LoginRepoImpl(this.loginRemoteDatasource, this.loginLocalDatasource);

  @override
  Future<BaseResponse<LoginModel>> login({
    String? email,
    String? password,
    bool? rememberMe,
  }) async {
    BaseResponse<LoginDto> loginResponse = await loginRemoteDatasource.login(
      email: email,
      password: password,
    );

    switch (loginResponse) {
      case SuccessResponse<LoginDto>():
        LoginDto dto = loginResponse.data;
        LoginModel loginModel = dto.toLoginModel();
        await storeToken(dto.token!);
        await saveRememberMe(rememberMe!);
        return SuccessResponse<LoginModel>(loginModel);
      case ErrorResponse<LoginDto, ErrorHandler>():
        return ErrorResponse<LoginModel, Failure>(
          error: loginResponse.error.failure,
        );
      default:
        throw Exception('Unexpected response type from loginRemoteDatasource');
    }
  }

  @override
  Future<void> storeToken(String token) async {
    await loginLocalDatasource.saveToken(token);
  }

  @override
  Future<void> saveRememberMe(bool value) async {
    await loginLocalDatasource.saveRememberMe(value);
  }

  @override
  Future<bool> isLoggedIn() async {
    String? token = await loginLocalDatasource.getToken();
    if (token != null) {
      logger.d('<<<<<<<<<<<<<<<<<<<<<<< retrieved token : $token');
      return true;
    } else {
      logger.d('<<<<<<<<<<<<<<<<<<<<<<< No token found');
      return false;
    }
  }
}
