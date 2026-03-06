import '../../../../../core/config/base_response/base_response.dart';
import '../models/login_dto.dart';

abstract class LoginRemoteDatasource {
  Future<BaseResponse<LoginDto>> login({
    String? email,
    String? password,
  });
}