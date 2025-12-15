import '../models/login_dto.dart';
import '../../domain/models/login_model.dart';

extension LoginDtoMapper on LoginDto {
  LoginModel toLoginModel() {
    return LoginModel(
      token: token,
      email: userdto?.email,
      userModel: userdto != null
          ? UserModel(
              firstName: userdto?.firstName,
              lastName: userdto?.lastName,
              id: userdto?.id,
            )
          : null,
    );
  }
}
