part of 'forget_password_bloc.dart';

sealed class ForgetPasswordEvent {
  const ForgetPasswordEvent();
}

class SendResetCodeEvent extends ForgetPasswordEvent {
  final String email;
  const SendResetCodeEvent({required this.email});
}

class VerifyCodeEvent extends ForgetPasswordEvent {
  final String email;
  final String code;
  const VerifyCodeEvent(this.email, this.code);
}

class ResetPasswordEvent extends ForgetPasswordEvent {
  final String email;
  final String password;
  final String confirmPassword;


  const ResetPasswordEvent(this.email, this.password, this.confirmPassword);
}

