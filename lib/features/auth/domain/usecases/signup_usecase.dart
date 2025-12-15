import 'package:dartz/dartz.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/auth/domain/models/signup_entity.dart';
import 'package:exam_app/features/auth/domain/models/signup_result_entity.dart';
import 'package:exam_app/features/auth/domain/repositories/auth_repo.dart';

import 'package:injectable/injectable.dart';

@injectable
class SignupUseCase {
  final AuthRepo repository;
  SignupUseCase({required this.repository});

  Future<Either<Failure, SignupResultEntity>> call(
    SignupEntity signupEntity,
  ) async => await repository.signup(signupEntity);
}
