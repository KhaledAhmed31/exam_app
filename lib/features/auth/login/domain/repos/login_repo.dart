import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/login/domain/models/login_model.dart';

abstract class LoginRepo {
  Future<BaseResponse<LoginModel>> login({String? email, String? password});

  Future<bool> isLoggedIn();
}
