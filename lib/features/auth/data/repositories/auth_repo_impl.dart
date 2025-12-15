import 'package:dartz/dartz.dart';
import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/auth/data/data_source/auth_local_datasource.dart';
import 'package:exam_app/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:exam_app/features/auth/data/mappers/login_dto_mapper.dart';
import 'package:exam_app/features/auth/data/models/login_dto.dart';
import 'package:exam_app/features/auth/data/models/reset_password_response.dart';
import 'package:exam_app/features/auth/data/models/send_reset_code_response.dart';
import 'package:exam_app/features/auth/data/models/signup_response_model.dart';
import 'package:exam_app/features/auth/data/models/verify_reset_code_response.dart';
import 'package:exam_app/features/auth/domain/models/login_model.dart';
import 'package:exam_app/features/auth/domain/models/signup_entity.dart';
import 'package:exam_app/features/auth/domain/models/signup_result_entity.dart';
import 'package:exam_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:exam_app/core/utils/api_call_helper.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final logger = Logger();
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;
  AuthRepoImpl({
    required this.authRemoteDatasource,
    required this.authLocalDatasource,
  });

  @override
  Future<bool> isLoggedIn() async {
    String? token = await authLocalDatasource.getToken();
    if (token != null) {
      logger.d('<<<<<<<<<<<<<<<<<<<<<<< retrieved token : $token');
      return true;
    } else {
      logger.d('<<<<<<<<<<<<<<<<<<<<<<< No token found');
      return false;
    }
  }

  @override
  Future<BaseResponse<LoginModel>> login({
    String? email,
    String? password,
    bool? rememberMe,
  }) async {
    BaseResponse<LoginDto> loginResponse = await authRemoteDatasource.login(
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
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    String email,
    String passowrd,
  ) async {
    BaseResponse<ResetPasswordResponse> result = await authRemoteDatasource
        .resetPassword(email, passowrd);
    switch (result) {
      case SuccessResponse<ResetPasswordResponse>():
        return result;
      case ErrorResponse<ResetPasswordResponse, ErrorHandler>():
        return ErrorResponse<ResetPasswordResponse, Failure>(
          error: result.error.failure,
        );
      default:
        return result;
    }
  }

  @override
  Future<void> saveRememberMe(bool value) async {
    await authLocalDatasource.saveRememberMe(value);
  }

  @override
  Future<BaseResponse<SendResetCodeResponse>> sendResetCode(
    String email,
  ) async {
    BaseResponse<SendResetCodeResponse> result = await authRemoteDatasource
        .sendResetCode(email);
    switch (result) {
      case SuccessResponse<SendResetCodeResponse>():
        return result;
      case ErrorResponse<SendResetCodeResponse, ErrorHandler>():
        return ErrorResponse<SendResetCodeResponse, Failure>(
          error: result.error.failure,
        );
      default:
        return result;
    }
  }

  @override
  Future<Either<Failure, SignupResultEntity>> signup(
    SignupEntity signupEntity,
  ) async {
    return ApiCallHelper.executeApiCall<
      SignupResultEntity,
      SignupResponseModel
    >(
      apiCall: () => authRemoteDatasource.signup(signupEntity),
      onSuccess: (response) => SignupResultEntity(
        message: response.message ?? 'Account created successfully',
        token: response.token,
      ),
    );
  }

  @override
  Future<void> storeToken(String token) async {
    await authLocalDatasource.saveToken(token);
  }

  @override
  Future<BaseResponse<VerifyResetCodeResponse>> verifyResetCode(
    String code,
  ) async {
    BaseResponse<VerifyResetCodeResponse> result = await authRemoteDatasource
        .verifyResetCode(code);
    switch (result) {
      case SuccessResponse<VerifyResetCodeResponse>():
        return result;
      case ErrorResponse<VerifyResetCodeResponse, ErrorHandler>():
        return ErrorResponse<VerifyResetCodeResponse, Failure>(
          error: result.error.failure,
        );
      default:
        return result;
    }
  }
}
