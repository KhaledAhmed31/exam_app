part of 'forget_password_bloc.dart';

sealed class ForgetPasswordEvent {
  const ForgetPasswordEvent();
}

class SendResetCodeEvent extends ForgetPasswordEvent {
  final String email;
  const SendResetCodeEvent({required this.email});
}

class VerifyCodeEvent extends ForgetPasswordEvent {
  final String code;
  const VerifyCodeEvent({required this.code});
}

class ResetPasswordEvent extends ForgetPasswordEvent {
  final String email;
  final String password;
  const ResetPasswordEvent({required this.email,required this.password});
}

