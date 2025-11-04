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

class AutoLoginEvent extends AuthEvents {}