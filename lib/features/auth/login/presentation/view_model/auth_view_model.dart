import 'package:exam_app/core/config/base_response/base_response.dart';
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
    : super(LoginInitialState()) {
    on<LoginEvents>(_login);
    on<IsLoggedInEvent>(_isLoggedIn);
    on<ChangeRememberMeEvent>(_changeRememberMe);
    on<EmailOnChangedEvent>(_onEmailChange);
    on<PasswordOnChangedEvent>(_onPasswordChange);
    on<AutoLoginEvent>(_autoLogin);
  }
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool rememberMe = false;
  final _storage = FlutterSecureStorage();

  void _login(LoginEvents event, Emitter<AuthStates> emit) async {
    emit(LoginLoadingState('Loading...'));
    BaseResponse<LoginModel> response = await _loginUescase.call(
      email: email,
      password: password,
    );
    switch (response) {
      case SuccessResponse<LoginModel>():
        await _saveData(response.data);
        emit(LoginSuccessState(data: response.data));
      case ErrorResponse<LoginModel>():
        emit(LoginErrorState('Something went wrong'));
    }
  }

  Future<void> _isLoggedIn(
    IsLoggedInEvent event,
    Emitter<AuthStates> emit,
  ) async {
    emit(LoginLoadingState('Checking login status...'));
    emit(IsLoggedInState(isLoggedIn: await _isLoggedInUsecase.call()));
  }

  void _changeRememberMe(
    ChangeRememberMeEvent event,
    Emitter<AuthStates> emit,
  ) {
    rememberMe = event.value ?? false;
    emit(ChangeRememberMeState());

    if (rememberMe) {
      add(AutoLoginEvent());
    }
  }

  void _onEmailChange(EmailOnChangedEvent event, Emitter<AuthStates> emit) {
    if (Validators.notEmpty(event.email)) {
      email = event.email!.trim();
    }
    emit(EmailOnChangedState());
  }

  void _onPasswordChange(
    PasswordOnChangedEvent event,
    Emitter<AuthStates> emit,
  ) {
    if (event.password != null) password = event.password!;
    emit(PasswordOnChangedState());
  }

  Future<void> _autoLogin(
    AutoLoginEvent event,
    Emitter<AuthStates> emit,
  ) async {
    emit(LoginLoadingState('Auto login loading...'));
    try {
      final savedEmail = await _storage.read(key: 'email');
      final savedPassword = await _storage.read(key: 'password');
      final savedRememberMe = await _storage.read(key: 'remember_me');
      print(
        '<<<<< AutoLogin: email=$savedEmail, password=$savedPassword, rememberMe=$savedRememberMe',
      );
      if (savedRememberMe == 'true' &&
          savedEmail != null &&
          savedPassword != null) {
        final response = await _loginUescase.call(
          email: savedEmail,
          password: savedPassword,
        );
        switch (response) {
          case SuccessResponse<LoginModel>():
            await _saveData(response.data);
            emit(LoginSuccessState(data: response.data));
            break;
          case ErrorResponse<LoginModel>():
            emit(LoginErrorState(response.message));
            break;
        }
      } else {
        emit(LoginInitialState());
      }
    } catch (e) {
      emit(LoginErrorState('Auto login catch: $e'));
    }
  }

  Future<void> _saveData(LoginModel loginModel) async {
    try {
      if (rememberMe) {
        await _storage.write(key: 'email', value: email);
        await _storage.write(key: 'password', value: password);
        await _storage.write(key: 'remember_me', value: 'true');

        final storedEmail = await _storage.read(key: 'email');
        final storedPassword = await _storage.read(key: 'password');
        final storedRememberMe = await _storage.read(key: 'remember_me');
        print(
          '<<<<<< Stored data: email=$storedEmail, password=$storedPassword, rememberMe=$storedRememberMe',
        );
      } else {
        await _storage.delete(key: 'email');
        await _storage.delete(key: 'password');
        await _storage.write(key: 'remember_me', value: 'false');
        print('<<<<<< Cleared saved data');
      }
    } catch (e) {
      print('<<<<<< Error saving data: $e');
    }
  }
}
