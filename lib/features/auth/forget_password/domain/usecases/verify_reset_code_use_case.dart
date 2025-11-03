import '../../../../../core/config/base_response/base_response.dart';
import '../../data/models/verify_reset_code_response.dart';
import '../repositories/forgetpassword_repo.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class VerifyResetCodeUseCase {
  final ForgetPawwordRepo forgetPasswordRepo;

  VerifyResetCodeUseCase(this.forgetPasswordRepo);
  Future<BaseResponse<VerifyResetCodeResponse>> call(String code) async=> await forgetPasswordRepo.verifyResetCode(code);
}