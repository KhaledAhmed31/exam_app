import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/reset_password_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/send_reset_code_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_response.dart';

abstract class ForgetPassordDataSource {
  Future<BaseResponse<SendResetCodeResponse>> sendResetCode(String email);

  Future<BaseResponse<VerifyResetCodeResponse>> verifyResetCode(String code);

  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    String email,
    String passowrd,
  );
}
