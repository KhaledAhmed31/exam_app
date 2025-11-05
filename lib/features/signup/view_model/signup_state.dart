part of 'signup_cubit.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final SignupResponseModel signupResponseModel;

  const SignupSuccess(this.signupResponseModel);

  @override
  List<Object> get props => [signupResponseModel];
}

class SignupError extends SignupState {
  final String message;

  const SignupError(this.message);

  @override
  List<Object> get props => [message];
}