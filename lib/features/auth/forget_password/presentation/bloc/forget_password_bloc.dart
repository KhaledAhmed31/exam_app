import 'dart:developer';

import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/data/models/send_reset_code_response.dart';
import 'package:exam_app/features/auth/forget_password/domain/usecases/send_reset_code_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

@lazySingleton
class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final SendResetCodeUseCase sendRestCodeRepo;
  String email = '';
  ForgetPasswordBloc(this.sendRestCodeRepo) : super(ForgetPasswordInitial()) {
    on<SendResetCodeEvent>(sendResetCode);
    on<VerifyCodeEvent>((event, emit) {});
    on<ResetPasswordEvent>((event, emit) {});
  }

  Future<void> sendResetCode(
    SendResetCodeEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(ForgetPasswordLoading());
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
}
