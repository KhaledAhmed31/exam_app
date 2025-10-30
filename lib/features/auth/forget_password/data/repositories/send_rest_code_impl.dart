import 'package:exam_app/core/config/base_response/base_response.dart';
import 'package:exam_app/features/auth/forget_password/data/data_source/send_reset_code_data_suorce.dart';
import 'package:exam_app/features/auth/forget_password/data/models/send_reset_code_response.dart';
import 'package:exam_app/features/auth/forget_password/domain/repositories/send_rest_code_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SendRestCodeRepo)
class SendRestCodeImpl implements SendRestCodeRepo{
  final SendResetCodeDataSuorce sendResetCodeDataSuorce;

  SendRestCodeImpl({required this.sendResetCodeDataSuorce});
  @override
  Future<BaseResponse<SendResetCodeResponse>> sendResetCode(String email) {
    return sendResetCodeDataSuorce.sendResetCode(email);
  }
}