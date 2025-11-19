import 'package:dio/dio.dart';
import 'package:exam_app/core/config/api/api_const.dart';
import 'package:exam_app/features/signup/data/models/signup_request_model.dart';
import 'package:exam_app/features/signup/data/models/signup_response_model.dart';
import 'package:exam_app/features/signup/domain/entities/signup_entity.dart';

abstract class SignupRemoteDataSource {
  Future<SignupResponseModel> signup(SignupEntity entity);
}

class SignupRemoteDataSourceImpl implements SignupRemoteDataSource {
  final Dio dio;

  SignupRemoteDataSourceImpl({required this.dio});

  @override
  Future<SignupResponseModel> signup(SignupEntity entity) async {
    final requestModel = SignupRequestModel.fromEntity(entity);
    
    final response = await dio.post(
      ApiConsts.registerEndPoint,
      data: requestModel.toJson(),
    );
    
    return SignupResponseModel.fromJson(response.data);
  }
}