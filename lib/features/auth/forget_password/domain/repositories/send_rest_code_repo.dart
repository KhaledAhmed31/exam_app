import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/send_reset_code_response.dart';

abstract class SendRestCodeRepo {
  Future<BaseResponse<SendResetCodeResponse>> sendResetCode(String email);
}