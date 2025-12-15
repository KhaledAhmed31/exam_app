abstract class AuthEvents {}

class LoginEvents extends AuthEvents {}

class IsLoggedInEvent extends AuthEvents {}

class ChangeRememberMeEvent extends AuthEvents {
  final bool? value;
  ChangeRememberMeEvent(this.value);
}

class EmailOnChangedEvent extends AuthEvents {
  final String? email;
  EmailOnChangedEvent(this.email);
}

class PasswordOnChangedEvent extends AuthEvents {
  final String? password;
  PasswordOnChangedEvent(this.password);
}

class SendResetCodeEvent extends AuthEvents {
  final String email;
  SendResetCodeEvent({required this.email});
}

class ResendResetCodeEvent extends AuthEvents {
  final String email;
  ResendResetCodeEvent({required this.email});
}

class VerifyCodeEvent extends AuthEvents {
  final String code;
  VerifyCodeEvent({required this.code});
}

class ResetPasswordEvent extends AuthEvents {
  final String email;
  final String password;
  ResetPasswordEvent({required this.email, required this.password});
}
