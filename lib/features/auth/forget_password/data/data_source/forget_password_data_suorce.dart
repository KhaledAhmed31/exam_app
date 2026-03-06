import '../../../../../core/config/base_response/base_response.dart';
import '../models/reset_password_response.dart';
import '../models/send_reset_code_response.dart';
import '../models/verify_reset_code_response.dart';

abstract class ForgetPassordDataSource {
  Future<BaseResponse<SendResetCodeResponse>> sendResetCode(String email);

  Future<BaseResponse<VerifyResetCodeResponse>> verifyResetCode(String code);

  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    String email,
    String passowrd,
  );
}
