import '../../../../../core/config/base_response/base_response.dart';
import '../../data/models/send_reset_code_response.dart';
import '../repositories/forgetpassword_repo.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SendResetCodeUseCase {
  final ForgetPawwordRepo sendRestCodeRepo;
  SendResetCodeUseCase({required this.sendRestCodeRepo});

  Future<BaseResponse<SendResetCodeResponse>> call(String email) {
    return sendRestCodeRepo.sendResetCode(email);
  }
}
