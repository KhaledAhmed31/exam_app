import '../../../../../core/config/base_response/base_response.dart';
import '../models/login_model.dart';

abstract class LoginRepo {
  Future<BaseResponse<LoginModel>> login({String? email, String? password});

  Future<bool> isLoggedIn();
}
