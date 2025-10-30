import 'package:dio/dio.dart';
import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/api/clients/send_reset_code_client.dart';
import 'package:exam_app/features/auth/forget_password/data/data_source/send_reset_code_data_suorce.dart';
import 'package:exam_app/features/auth/forget_password/data/models/send_reset_code_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SendResetCodeDataSuorce)
class SendResetCodeDataSuorceImpl implements SendResetCodeDataSuorce {
  final SendResetCodeClient _sendResetCodeClient;
  SendResetCodeDataSuorceImpl(this._sendResetCodeClient);

  @override
  Future<BaseResponse<SendResetCodeResponse>> sendResetCode(
    String email,
  ) async {
    try {
      SendResetCodeResponse response = await _sendResetCodeClient.sendRestCode(
        {"email": email},
      );
      return SuccessResponse(response);
    } catch (e) {
      if (e is DioException) {
        return ErrorResponse(e.response!.data['message']);
      }
      return ErrorResponse("Something went wrong");
    }
  }
}
