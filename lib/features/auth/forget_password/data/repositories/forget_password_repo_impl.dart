import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/data/data_source/forget_password_data_suorce.dart';
import 'package:exam_app/features/auth/forget_password/data/models/send_reset_code_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_response.dart';
import 'package:exam_app/features/auth/forget_password/domain/repositories/forgetpassword_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ForgetPawwordRepo)
class ForgetPasswordRepoImpl implements ForgetPawwordRepo {
  final ForgetPassordDataSource forgetPasswordDataSource;

  ForgetPasswordRepoImpl({required this.forgetPasswordDataSource});
  @override
  Future<BaseResponse<SendResetCodeResponse>> sendResetCode(String email) {
    return forgetPasswordDataSource.sendResetCode(email);
  }

  @override
  Future<BaseResponse<SendResetCodeResponse>> resetPassword(
    String email,
    String passowrd,
  ) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override

  Future<BaseResponse<VerifyResetCodeResponse>> verifyResetCode(String code) {
    return forgetPasswordDataSource.verifyResetCode(code);
  }

  //   @override
  //   Future<BaseResponse<VerifyResetCodeResponse>> verifyResetCode(String code) {
  //     try {
  //       return sendResetCodeDataSuorce.verifyResetCode(code);
  //     } catch (e) {

  //       return ErrorResponse("");
  //     }
  //   }
}
