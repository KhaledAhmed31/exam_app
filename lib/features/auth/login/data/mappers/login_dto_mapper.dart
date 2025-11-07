import 'package:exam_app/features/auth/login/data/models/login_dto.dart';
import 'package:exam_app/features/auth/login/domain/models/login_model.dart';

extension LoginDtoMapper on LoginDto {
  LoginModel toLoginModel() {
    return LoginModel(
      email: userdto?.email,
      // password: userdto?.,
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
