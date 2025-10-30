import 'package:exam_app/core/config/validation/app_validation.dart';
import 'package:exam_app/features/auth/login/presentation/view_model/auth_states.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthViewModel extends Cubit<AuthStates> {
  AuthViewModel() : super(LoginInitialState());
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool rememberMe = false;

  void changeRememberMe(bool? value) {
    rememberMe = value ?? false;
    emit(ChangeRememberMeState());
  }

  void onEmailChange(String? email) {
    if (Validators.notEmpty(email)) {
      this.email = email!.trim();
    }
    emit(EmailOnChanged());
  }

  void onPasswordChange(String? password) {
    if (password != null) this.password = password;
    emit(PasswordOnChanged());
  }

  bool isLoginButtonDisabled() =>
      !(Validators.emailValidator(email) == null &&
          Validators.passwordValidator(password) == null);

  void login() {}
}
