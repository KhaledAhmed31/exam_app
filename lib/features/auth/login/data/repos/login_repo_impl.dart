// ignore_for_file: avoid_print

import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/auth/login/data/datasources/login_local_datasource.dart';
import 'package:exam_app/features/auth/login/data/datasources/login_remote_datasource.dart';
import 'package:exam_app/features/auth/login/data/mappers/login_dto_mapper.dart';
import 'package:exam_app/features/auth/login/data/models/login_dto.dart';
import 'package:exam_app/features/auth/login/domain/models/login_model.dart';
import 'package:exam_app/features/auth/login/domain/repos/login_repo.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {
  LoginRemoteDatasource loginRemoteDatasource;
  LoginLocalDatasource loginLocalDatasource;
  LoginRepoImpl(this.loginRemoteDatasource, this.loginLocalDatasource);

  @override
  Future<BaseResponse<LoginModel>> login({
    String? email,
    String? password,
  }) async {
    BaseResponse<LoginDto> loginResponse = await loginRemoteDatasource.login(
      email: email,
      password: password,
    );

    switch (loginResponse) {
      case SuccessResponse<LoginDto>():
        LoginDto dto = loginResponse.data;
        LoginModel loginModel = dto.toLoginModel();
        if (dto.token != null) {
          await loginLocalDatasource.saveToken(dto.token!);
        }
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
  Future<bool> isLoggedIn() async {
    String? token = await loginLocalDatasource.getToken();
    if (token != null) {
      print('<<<<<<<<<<<<<<<<<<<<<<< retrieved token : $token');
      return true;
    } else {
      print('<<<<<<<<<<<<<<<<<<<<<<< No token found');
      return false;
    }
  }
}
