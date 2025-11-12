import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/core/config/di/di.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/core/config/validation/app_validation.dart';
import 'package:exam_app/features/auth/login/domain/models/login_model.dart';
import 'package:exam_app/features/auth/login/domain/usecases/is_loggedin_usecase.dart';
import 'package:exam_app/features/auth/login/domain/usecases/login_uescase.dart';
import 'package:exam_app/features/auth/login/presentation/view_model/auth_events.dart';
import 'package:exam_app/features/auth/login/presentation/view_model/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthViewModel extends Bloc<AuthEvents, AuthStates> {
  final LoginUescase _loginUescase;
  final IsLoggedInUsecase _isLoggedInUsecase;
  AuthViewModel(this._loginUescase, this._isLoggedInUsecase)
    : super(AuthStates()) {
    on<LoginEvents>(_login);
    on<IsLoggedInEvent>(_isLoggedIn);
    on<ChangeRememberMeEvent>(_changeRememberMe);
    on<EmailOnChangedEvent>(_onEmailChange);
    on<PasswordOnChangedEvent>(_onPasswordChange);
  }

  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool rememberMe = false;
  final FlutterSecureStorage _storage = getIt<FlutterSecureStorage>();

  void _login(LoginEvents event, Emitter<AuthStates> emit) async {
    emit(state.copywith(loginStateCopywith: LoginState(isLoading: true)));
    BaseResponse<LoginModel> response = await _loginUescase.call(
      email: email,
      password: password,
    );
    switch (response) {
      case SuccessResponse<LoginModel>():
        if (rememberMe) {
          await _storage.write(key: 'token', value: response.data.token);
          await _storage.write(key: 'remember_me', value: 'true');
        }
        emit(
          state.copywith(
            loginStateCopywith: LoginState(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
      case ErrorResponse<LoginModel, Failure>():
        emit(
          state.copywith(
            loginStateCopywith: LoginState(
              isLoading: false,
              errorMessage: response.error.message,
            ),
          ),
        );
    }
  }

  Future<void> _isLoggedIn(
    IsLoggedInEvent event,
    Emitter<AuthStates> emit,
  ) async {
    emit(
      state.copywith(
        loginStateCopywith: LoginState(
          isLoggedIn: await _isLoggedInUsecase.call(),
        ),
      ),
    );
  }

  void _changeRememberMe(
    ChangeRememberMeEvent event,
    Emitter<AuthStates> emit,
  ) async {
    rememberMe = event.value ?? false;
    await _storage.write(key: 'remember_me', value: rememberMe.toString());
    emit(
      state.copywith(loginStateCopywith: LoginState(changeRememberMe: true)),
    );
  }

  void _onEmailChange(EmailOnChangedEvent event, Emitter<AuthStates> emit) {
    if (Validators.notEmpty(event.email)) {
      email = event.email!.trim();
    }
    emit(state.copywith(loginStateCopywith: LoginState(changeOnEmail: true)));
  }

  void _onPasswordChange(
    PasswordOnChangedEvent event,
    Emitter<AuthStates> emit,
  ) {
    if (event.password != null) password = event.password!;
    emit(
      state.copywith(loginStateCopywith: LoginState(changeOnPassword: true)),
    );
  }
}
