import 'package:dartz/dartz.dart';
import 'package:exam_app/core/shared/error/failure.dart';
import 'package:exam_app/features/signup/domain/entities/signup_entity.dart';
import 'package:exam_app/features/signup/domain/repositories/signup_repository.dart';

import 'package:exam_app/features/signup/data/models/signup_response_model.dart';

class SignupUseCase {
  final SignupRepository repository;

  SignupUseCase({required this.repository});

  Future<Either<Failure, SignupResponseModel>> call(
      SignupEntity signupEntity) async {
    return await repository.signup(signupEntity);
  }
}