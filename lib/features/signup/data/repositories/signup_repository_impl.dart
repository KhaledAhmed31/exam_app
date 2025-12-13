import 'package:dartz/dartz.dart';
import 'package:exam_app/core/shared/error/failure.dart';
import 'package:exam_app/core/utils/api_call_helper.dart';
import 'package:exam_app/features/signup/data/datasources/signup_remote_data_source.dart';
import 'package:exam_app/features/signup/data/models/signup_response_model.dart';
import 'package:exam_app/features/signup/domain/entities/signup_entity.dart';
import 'package:exam_app/features/signup/domain/entities/signup_result_entity.dart';
import 'package:exam_app/features/signup/domain/repositories/signup_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SignupRepository)
class SignupRepositoryImpl implements SignupRepository {
  final SignupRemoteDataSource remoteDataSource;

  SignupRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SignupResultEntity>> signup(
    SignupEntity signupEntity,
  ) async {
    return ApiCallHelper.executeApiCall<
      SignupResultEntity,
      SignupResponseModel
    >(
      apiCall: () => remoteDataSource.signup(signupEntity),
      onSuccess: (response) => SignupResultEntity(
        message: response.message ?? 'Account created successfully',
        token: response.token,
      ),
    );
  }
}
