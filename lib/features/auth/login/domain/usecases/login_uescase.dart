import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/login/domain/models/login_model.dart';
import 'package:exam_app/features/auth/login/domain/repos/login_repo.dart';
import 'package:injectable/injectable.dart';

@singleton
class LoginUescase {
  LoginRepo loginRepo;
  LoginUescase(this.loginRepo);
    Future<BaseResponse<LoginModel>> call({
    String? email,
    String? password,
    }) => loginRepo.login(email: email, password: password);
}
