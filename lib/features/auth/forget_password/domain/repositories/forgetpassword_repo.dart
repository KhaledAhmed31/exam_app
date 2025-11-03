import '../../../../../core/config/base_response/base_response.dart';
import '../../data/models/reset_password_response.dart';
import '../../data/models/send_reset_code_response.dart';
import '../../data/models/verify_reset_code_response.dart';

abstract class ForgetPawwordRepo {
  Future<BaseResponse<SendResetCodeResponse>> sendResetCode(String email);
  Future<BaseResponse<VerifyResetCodeResponse>> verifyResetCode(String code);
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(String email, String passowrd);
}
