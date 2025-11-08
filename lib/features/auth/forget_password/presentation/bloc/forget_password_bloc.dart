import 'dart:developer';

import '../../../../../core/config/base_response/base_response.dart';
import '../../../../../core/config/error/error_handler.dart';
import '../../data/models/reset_password_response.dart';
import '../../data/models/send_reset_code_response.dart';
import '../../data/models/verify_reset_code_response.dart';
import '../../domain/usecases/reset_password_use_case.dart';
import '../../domain/usecases/send_reset_code_use_case.dart';
import '../../domain/usecases/verify_reset_code_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

@lazySingleton
class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final SendResetCodeUseCase sendRestCodeUseCase;
  final VerifyResetCodeUseCase verifyResetCodeUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  String email = '';
  ForgetPasswordBloc(
    this.sendRestCodeUseCase,
    this.verifyResetCodeUseCase,
    this.resetPasswordUseCase,
  ) : super(ForgetPasswordInitial()) {
    on<SendResetCodeEvent>(sendResetCode);
    on<VerifyCodeEvent>(verifyResetCode);
    on<ResetPasswordEvent>(resetPassword);
    on<ResendResetCodeEvent>(resendResetCode);
  }

  Future<void> sendResetCode(
    SendResetCodeEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(ForgetPasswordLoading());
    email = event.email;
    BaseResponse<SendResetCodeResponse> result = await sendRestCodeUseCase(
      event.email,
    );
    switch (result) {
      case SuccessResponse<SendResetCodeResponse>():
        log("Success");
        emit(ForgetPasswordSuccess());
      case ErrorResponse<SendResetCodeResponse, Failure>():
        log(result.error.message);
        emit(ForgetPasswordError(result.error.message));
    }
  }

   Future<void> resendResetCode(
    ResendResetCodeEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(ForgetPasswordLoading());
    email = event.email;
    BaseResponse<SendResetCodeResponse> result = await sendRestCodeUseCase(
      event.email,
    );
    switch (result) {
      case SuccessResponse<SendResetCodeResponse>():
        log("Success");
        emit(ResendCodeSuccess());
      case ErrorResponse<SendResetCodeResponse, Failure>():
        log(result.error.message);
        emit(ForgetPasswordError(result.error.message));
    }
  }

  Future<void> verifyResetCode(
    VerifyCodeEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(ForgetPasswordLoading());
    BaseResponse<VerifyResetCodeResponse> result = await verifyResetCodeUseCase(
      event.code,
    );
    switch (result) {
      case SuccessResponse<VerifyResetCodeResponse>():
        log("Success");
        emit(ForgetPasswordSuccess());
      case ErrorResponse<VerifyResetCodeResponse, Failure>():
        log(result.error.message);
        emit(ForgetPasswordError(result.error.message));
    }
  }

  Future<void> resetPassword(
    ResetPasswordEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(ForgetPasswordLoading());
    BaseResponse<ResetPasswordResponse> result = await resetPasswordUseCase(
      email,
      event.password,
    );
    switch (result) {
      case SuccessResponse<ResetPasswordResponse>():
        log("Success");
        emit(ResetPasswordSuccess());
      case ErrorResponse<ResetPasswordResponse, Failure>():
        log(result.error.message);
        emit(ForgetPasswordError(result.error.message));
    }
  }
}
