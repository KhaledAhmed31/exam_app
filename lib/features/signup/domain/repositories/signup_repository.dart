import 'package:dartz/dartz.dart';
import 'package:exam_app/core/shared/error/failure.dart';
import 'package:exam_app/features/signup/data/models/signup_response_model.dart';
import 'package:exam_app/features/signup/domain/entities/signup_entity.dart';

abstract class SignupRepository {
  Future<Either<Failure, SignupResponseModel>> signup(SignupEntity signupEntity);
}