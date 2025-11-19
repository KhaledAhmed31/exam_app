import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exam_app/features/signup/data/models/signup_response_model.dart';
import 'package:exam_app/features/signup/domain/entities/signup_entity.dart';
import 'package:exam_app/features/signup/domain/usecases/signup_usecase.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase _signupUseCase;
  SignupCubit(this._signupUseCase) : super(SignupInitial());

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
    required String userName,
  }) async {
    emit(SignupLoading());
    final result = await _signupUseCase(SignupEntity(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phone: phone,
      userName: userName,
    ));
    result.fold(
      (failure) => emit(SignupError(failure.message)),
      (signupResponse) => emit(SignupSuccess(signupResponse)),
    );
  }
}