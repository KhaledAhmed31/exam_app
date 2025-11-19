import 'package:dartz/dartz.dart';
import 'package:exam_app/core/shared/error/failure.dart';
import 'package:exam_app/features/signup/data/datasources/signup_remote_data_source.dart';
import 'package:exam_app/features/signup/domain/entities/signup_entity.dart';
import 'package:exam_app/features/signup/domain/repositories/signup_repository.dart';

import 'package:exam_app/features/signup/data/models/signup_response_model.dart';

class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteDataSource remoteDataSource;

  SignupRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SignupResponseModel>> signup(
      SignupEntity signupEntity) async {
    try {
      final result = await remoteDataSource.signup(signupEntity);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}