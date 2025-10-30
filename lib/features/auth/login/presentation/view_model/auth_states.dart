abstract class AuthStates {}

class LoginStates extends AuthStates {}

class LoginInitialState extends LoginStates {}

class ChangeRememberMeState extends LoginStates {}

class EmailOnChanged extends LoginStates {}

class PasswordOnChanged extends LoginStates {}

class LoginLoadingState extends LoginStates {
  String loadingMessage;
  LoginLoadingState(this.loadingMessage);
}

class LoginSuccessState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String errorMessage;
  LoginErrorState(this.errorMessage);
}
