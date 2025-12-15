import 'package:exam_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/config/base_response/base_response.dart';
import '../../data/models/send_reset_code_response.dart';

@lazySingleton
class SendResetCodeUseCase {
  final AuthRepo sendRestCodeRepo;
  SendResetCodeUseCase({required this.sendRestCodeRepo});

  Future<BaseResponse<SendResetCodeResponse>> call(String email) {
    return sendRestCodeRepo.sendResetCode(email);
  }
}
