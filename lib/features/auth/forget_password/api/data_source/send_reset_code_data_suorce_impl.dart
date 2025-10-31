import 'package:dio/dio.dart';
import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/api/clients/send_reset_code_client.dart';
import 'package:exam_app/features/auth/forget_password/api/clients/verify_reset_code_client.dart';
import 'package:exam_app/features/auth/forget_password/data/data_source/forget_password_data_suorce.dart';
import 'package:exam_app/features/auth/forget_password/data/models/send_reset_code_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ForgetPassordDataSource)
class SendResetCodeDataSuorceImpl implements ForgetPassordDataSource {
  final SendResetCodeClient _sendResetCodeClient;
  final VerifyResetCodeClient _verifyResetCodeClient;
  SendResetCodeDataSuorceImpl(
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
      if (e is DioException) {
        return ErrorResponse(e.response!.data['message']);
      }
      return ErrorResponse("Something went wrong");
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
      if (e is DioException) {
        return ErrorResponse(e.response!.data['message']);
      }
      return ErrorResponse("Something went wrong");
    }
  }

  @override
  Future<BaseResponse<SendResetCodeResponse>> resetPassword(
    String email,
    String passowrd,
  ) async {
    throw UnimplementedError();
    // return await _verifyResetCodeClient.verifyResetCode({"email": email, "password": passowrd});
  }
}
