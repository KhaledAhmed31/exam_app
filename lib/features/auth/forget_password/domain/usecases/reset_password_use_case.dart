import '../../../../../core/config/base_response/base_response.dart';
import '../../data/models/reset_password_response.dart';
import '../repositories/forgetpassword_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResetPasswordUseCase {
  final ForgetPawwordRepo forgetPawwordRepo;
  ResetPasswordUseCase(this.forgetPawwordRepo);
  Future<BaseResponse<ResetPasswordResponse>> call(
    String email,
    String password,
  ) async => await forgetPawwordRepo.resetPassword(email, password);
}
