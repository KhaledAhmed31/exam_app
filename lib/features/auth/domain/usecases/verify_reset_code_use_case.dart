import 'package:exam_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/config/base_response/base_response.dart';
import '../../data/models/verify_reset_code_response.dart';

@lazySingleton
class VerifyResetCodeUseCase {
  final AuthRepo forgetPasswordRepo;

  VerifyResetCodeUseCase(this.forgetPasswordRepo);
  Future<BaseResponse<VerifyResetCodeResponse>> call(String code) async =>
      await forgetPasswordRepo.verifyResetCode(code);
}
