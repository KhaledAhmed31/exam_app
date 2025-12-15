part of 'signup_cubit.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final SignupResultEntity signupResult;

  const SignupSuccess(this.signupResult);

  @override
  List<Object> get props => [signupResult];
}

class SignupError extends SignupState {
  final String message;

  const SignupError(this.message);

  @override
  List<Object> get props => [message];
}
