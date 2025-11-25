import '../../../../../core/config/base_state/base_state.dart';
import '../../domain/models/login_model.dart';

class AuthStates {
  LoginState? loginState;
  AuthStates({this.loginState});
  AuthStates copywith({LoginState? loginStateCopywith}) {
    return AuthStates(loginState: loginStateCopywith ?? loginState);
  }
}

class LoginState extends BaseState<LoginModel> {
  final bool? isLoggedIn;
  final bool? changeRememberMe;
  final bool? changeOnEmail;
  final bool? changeOnPassword;

  LoginState({
    super.isLoading,
    super.data,
    super.errorMessage,
    this.isLoggedIn,
    this.changeRememberMe,
    this.changeOnEmail,
    this.changeOnPassword,
  });
}
