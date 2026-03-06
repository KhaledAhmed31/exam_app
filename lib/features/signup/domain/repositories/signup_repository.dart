import 'package:dartz/dartz.dart';
import 'package:exam_app/core/shared/error/failure.dart';
import 'package:exam_app/features/signup/domain/entities/signup_entity.dart';
import 'package:exam_app/features/signup/domain/entities/signup_result_entity.dart';

abstract class SignupRepository {
  Future<Either<Failure, SignupResultEntity>> signup(SignupEntity signupEntity);
}
