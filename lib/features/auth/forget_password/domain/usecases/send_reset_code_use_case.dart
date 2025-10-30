import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/send_reset_code_response.dart';
import 'package:exam_app/features/auth/forget_password/domain/repositories/send_rest_code_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SendResetCodeUseCase {
  final SendRestCodeRepo sendRestCodeRepo;
  SendResetCodeUseCase({required this.sendRestCodeRepo});

  Future<BaseResponse<SendResetCodeResponse>> call(String email) {
    return sendRestCodeRepo.sendResetCode(email);
  }
}