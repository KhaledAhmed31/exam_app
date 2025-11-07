import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/login/data/models/login_dto.dart';

abstract class LoginRemoteDatasource {
  Future<BaseResponse<LoginDto>> login({
    String? email,
    String? password,
  });
}