import 'dart:developer';

import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/send_reset_code_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/verify_reset_code_response.dart';
import 'package:exam_app/features/auth/forget_password/domain/usecases/send_reset_code_use_case.dart';
import 'package:exam_app/features/auth/forget_password/domain/usecases/verify_reset_code_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

@lazySingleton
class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final SendResetCodeUseCase sendRestCodeRepo;
  final VerifyResetCodeUseCase verifyResetCodeRepo;
  String email = '';
  ForgetPasswordBloc(this.sendRestCodeRepo, this.verifyResetCodeRepo)
    : super(ForgetPasswordInitial()) {
    on<SendResetCodeEvent>(sendResetCode);
    on<VerifyCodeEvent>(verifyResetCode);
    on<ResetPasswordEvent>(resetPassword);
  }

  Future<void> sendResetCode(
    SendResetCodeEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(ForgetPasswordLoading());
    email = event.email;
    BaseResponse<SendResetCodeResponse> result = await sendRestCodeRepo(
      event.email,
    );
    switch (result) {
      case SuccessResponse<SendResetCodeResponse>():
        log("Success");
        emit(ForgetPasswordSuccess());
      case ErrorResponse<SendResetCodeResponse>():
        log(result.message);
        emit(ForgetPasswordError(result.message));
    }
  }

  Future<void> verifyResetCode(
    VerifyCodeEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(ForgetPasswordLoading());
    BaseResponse<VerifyResetCodeResponse> result = await verifyResetCodeRepo(
      event.code,
    );
    switch (result) {
      case SuccessResponse<VerifyResetCodeResponse>():
        log("Success");
        emit(ForgetPasswordSuccess());
      case ErrorResponse<VerifyResetCodeResponse>():
        log(result.message);
        emit(ForgetPasswordError(result.message));
    }
  }

  Future<void> resetPassword(
    ResetPasswordEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {}
}
