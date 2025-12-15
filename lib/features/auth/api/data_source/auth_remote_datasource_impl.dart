import 'package:dio/dio.dart';
import 'package:exam_app/core/config/api/api_const.dart';
import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/auth/api/clients/auth_api_client.dart';
import 'package:exam_app/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:exam_app/features/auth/data/models/login_dto.dart';
import 'package:exam_app/features/auth/data/models/reset_password_response.dart';
import 'package:exam_app/features/auth/data/models/send_reset_code_response.dart';
import 'package:exam_app/features/auth/data/models/signup_request_model.dart';
import 'package:exam_app/features/auth/data/models/signup_response_model.dart';
import 'package:exam_app/features/auth/data/models/verify_reset_code_response.dart';
import 'package:exam_app/features/auth/domain/models/signup_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  AuthApiClient authApiClient;
  final Dio dio;
  AuthRemoteDatasourceImpl(this.authApiClient, this.dio);
  @override
  Future<BaseResponse<LoginDto>> login({
    String? email,
    String? password,
  }) async {
    try {
      LoginDto loginResponse = await authApiClient.login({
        "email": email,
        "password": password,
      });
      return SuccessResponse<LoginDto>(loginResponse);
    } catch (e) {
      return ErrorResponse(error: ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<SendResetCodeResponse>> sendResetCode(
    String email,
  ) async {
    try {
      SendResetCodeResponse response = await authApiClient.sendResetCode({
        "email": email,
      });
      return SuccessResponse(response);
    } catch (e) {
      return ErrorResponse(error: ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<VerifyResetCodeResponse>> verifyResetCode(
    String code,
  ) async {
    try {
      VerifyResetCodeResponse response = await authApiClient.verifyResetCode({
        "resetCode": code,
      });
      return SuccessResponse(response);
    } catch (e) {
      return ErrorResponse(error: ErrorHandler.handle(e));
    }
  }

  @override
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    String email,
    String passowrd,
  ) async {
    try {
      ResetPasswordResponse response = await authApiClient.resetPassword({
        "email": email,
        "newPassword": passowrd,
      });

      return SuccessResponse(response);
    } catch (e) {
      return ErrorResponse(error: ErrorHandler.handle(e));
    }
  }

  @override
  Future<SignupResponseModel> signup(SignupEntity entity) async {
    final requestModel = SignupRequestModel.fromEntity(entity);

    final response = await dio.post(
      ApiConsts.signupEndPoint,
      data: requestModel.toJson(),
    );

    return SignupResponseModel.fromJson(response.data);
  }
}
