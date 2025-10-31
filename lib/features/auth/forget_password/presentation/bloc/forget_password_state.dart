part of 'forget_password_bloc.dart';

sealed class ForgetPasswordState {
  const ForgetPasswordState();  

 
}
class ForgetPasswordInitial extends ForgetPasswordState {}
class ForgetPasswordLoading extends ForgetPasswordState {}
class ForgetPasswordSuccess extends ForgetPasswordState {}
class ForgetPasswordError extends ForgetPasswordState {
  final String message;
  const ForgetPasswordError(this.message);
}
class ResendCodeSuccess extends ForgetPasswordState {

}
