import 'package:exam_app/features/auth/domain/repositories/auth_repo.dart';
import '../../../../core/config/base_response/base_response.dart';
import '../../data/models/reset_password_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ResetPasswordUseCase {
  final AuthRepo forgetPawwordRepo;
  ResetPasswordUseCase(this.forgetPawwordRepo);
  Future<BaseResponse<ResetPasswordResponse>> call(
    String email,
    String password,
  ) async => await forgetPawwordRepo.resetPassword(email, password);
}
