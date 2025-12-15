import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/data/models/login_dto.dart';
import 'package:exam_app/features/auth/data/models/reset_password_response.dart';
import 'package:exam_app/features/auth/data/models/send_reset_code_response.dart';
import 'package:exam_app/features/auth/data/models/signup_response_model.dart';
import 'package:exam_app/features/auth/data/models/verify_reset_code_response.dart';
import 'package:exam_app/features/auth/domain/models/signup_entity.dart';

abstract class AuthRemoteDatasource {
   Future<BaseResponse<SendResetCodeResponse>> sendResetCode(String email);

  Future<BaseResponse<VerifyResetCodeResponse>> verifyResetCode(String code);

  Future<BaseResponse<ResetPasswordResponse>> resetPassword(
    String email,
    String passowrd,
  );

  Future<BaseResponse<LoginDto>> login({
    String? email,
    String? password,
  });

   Future<SignupResponseModel> signup(SignupEntity entity);
}