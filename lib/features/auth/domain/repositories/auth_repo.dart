import 'package:dartz/dartz.dart';
import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/auth/data/models/reset_password_response.dart';
import 'package:exam_app/features/auth/data/models/send_reset_code_response.dart';
import 'package:exam_app/features/auth/data/models/verify_reset_code_response.dart';
import 'package:exam_app/features/auth/domain/models/login_model.dart';
import 'package:exam_app/features/auth/domain/models/signup_entity.dart';
import 'package:exam_app/features/auth/domain/models/signup_result_entity.dart';

abstract class AuthRepo {
  Future<BaseResponse<SendResetCodeResponse>> sendResetCode(String email);
  Future<BaseResponse<VerifyResetCodeResponse>> verifyResetCode(String code);
  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    String email,
    String passowrd,
  );

  Future<BaseResponse<LoginModel>> login({
    String? email,
    String? password,
    bool? rememberMe,
  });
  Future<bool> isLoggedIn();
  Future<void> storeToken(String token);
  Future<void> saveRememberMe(bool value);

  Future<Either<Failure, SignupResultEntity>> signup(SignupEntity signupEntity);
}
