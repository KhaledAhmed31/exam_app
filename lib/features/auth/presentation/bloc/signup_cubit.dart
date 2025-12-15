import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exam_app/features/auth/domain/models/signup_entity.dart';
import 'package:exam_app/features/auth/domain/models/signup_result_entity.dart';
import 'package:exam_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:injectable/injectable.dart';

part 'signup_state.dart';

@injectable
class SignupCubit extends Cubit<SignupState> {
  final SignupUseCase _signupUseCase;

  SignupCubit(this._signupUseCase) : super(SignupInitial());

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
    required String userName,
  }) async {
    emit(SignupLoading());

    final result = await _signupUseCase(
      SignupEntity(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone,
        userName: userName,
      ),
    );

    result.fold(
      (failure) => emit(SignupError(failure.message)),
      (signupResult) => emit(SignupSuccess(signupResult)),
    );
  }
}
