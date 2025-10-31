import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_response.dart';
import 'package:exam_app/features/auth/forget_password/domain/repositories/forgetpassword_repo.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class VerifyResetCodeUseCase {
  final ForgetPawwordRepo forgetPasswordRepo;

  VerifyResetCodeUseCase(this.forgetPasswordRepo);
  Future<BaseResponse<VerifyResetCodeResponse>> call(String code) async=> await forgetPasswordRepo.verifyResetCode(code);
}