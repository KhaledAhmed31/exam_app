import '../../../../../core/config/base_response/base_response.dart';
import '../models/login_model.dart';

abstract class LoginRepo {
  Future<BaseResponse<LoginModel>> login({
    String? email,
    String? password,
    bool? rememberMe,
  });

  Future<bool> isLoggedIn();

  Future<void> storeToken(String token);

  Future<void> saveRememberMe(bool value);
}
