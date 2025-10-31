import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/auth/forget_password/api/clients/reset_password_client.dart';
import 'package:exam_app/features/auth/forget_password/api/clients/send_reset_code_client.dart';
import 'package:exam_app/features/auth/forget_password/api/clients/verify_reset_code_client.dart';
import 'package:exam_app/features/auth/forget_password/data/data_source/forget_password_data_suorce.dart';
import 'package:exam_app/features/auth/forget_password/data/models/reset_password_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/send_reset_code_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ForgetPassordDataSource)
class SendResetCodeDataSuorceImpl implements ForgetPassordDataSource {
  final SendResetCodeClient _sendResetCodeClient;
  final VerifyResetCodeClient _verifyResetCodeClient;
  final ResetPasswordClient _resetPasswordClient;
  SendResetCodeDataSuorceImpl(
    this._resetPasswordClient,
    this._sendResetCodeClient,
    this._verifyResetCodeClient,
  );

  @override
  Future<BaseResponse<SendResetCodeResponse>> sendResetCode(
    String email,
  ) async {
    try {
      SendResetCodeResponse response = await _sendResetCodeClient.sendRestCode({
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
      VerifyResetCodeResponse response = await _verifyResetCodeClient
          .verifyResetCode({"resetCode": code});
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
      ResetPasswordResponse response = await _resetPasswordClient.resetPassword(
        {"email": email, "newPassword": passowrd},
      );
      return SuccessResponse(response);
    } catch (e) {
      return ErrorResponse(error: ErrorHandler.handle(e));
    }
  }
}
