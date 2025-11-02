import 'package:exam_app/features/auth/login/domain/models/login_model.dart';

abstract class AuthStates {}

class LoginStates extends AuthStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {
  String loadingMessage;
  LoginLoadingState(this.loadingMessage);
}

class LoginSuccessState extends LoginStates {
  LoginModel? data;
  LoginSuccessState({this.data});
}

class LoginErrorState extends LoginStates {
  final String errorMessage;
  LoginErrorState(this.errorMessage);
}

class IsLoggedInState extends AuthStates {
  final bool isLoggedIn;
  IsLoggedInState({required this.isLoggedIn});
}

class ChangeRememberMeState extends LoginStates {}

class EmailOnChangedState extends LoginStates {}

class PasswordOnChangedState extends LoginStates {}
