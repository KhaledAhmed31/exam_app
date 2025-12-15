import 'package:exam_app/features/auth/domain/repositories/auth_repo.dart';
import '../../../../core/config/base_response/base_response.dart';
import '../models/login_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUescase {
  AuthRepo loginRepo;
  LoginUescase(this.loginRepo);
  Future<BaseResponse<LoginModel>> call({
    String? email,
    String? password,
    bool? rememberMe,
  }) =>
      loginRepo.login(email: email, password: password, rememberMe: rememberMe);
}
