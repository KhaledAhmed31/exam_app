import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/auth/forget_password/data/data_source/forget_password_data_suorce.dart';
import 'package:exam_app/features/auth/forget_password/data/models/reset_password_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/send_reset_code_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_response.dart';
import 'package:exam_app/features/auth/forget_password/domain/repositories/forgetpassword_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ForgetPawwordRepo)
class ForgetPasswordRepoImpl implements ForgetPawwordRepo {
  final ForgetPassordDataSource forgetPasswordDataSource;

  ForgetPasswordRepoImpl({required this.forgetPasswordDataSource});
  @override
  Future<BaseResponse<SendResetCodeResponse>> sendResetCode(
    String email,
  ) async {
    BaseResponse<SendResetCodeResponse> result = await forgetPasswordDataSource
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
  Future<BaseResponse<VerifyResetCodeResponse>> verifyResetCode(
    String code,
  ) async {
    BaseResponse<VerifyResetCodeResponse> result =
        await forgetPasswordDataSource.verifyResetCode(code);
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

  @override
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    String email,
    String passowrd,
  ) async {
    BaseResponse<ResetPasswordResponse> result = await forgetPasswordDataSource
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
}
