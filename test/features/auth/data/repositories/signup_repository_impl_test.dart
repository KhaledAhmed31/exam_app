import 'package:dartz/dartz.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/auth/api/data_source/auth_local_datasource_impl.dart';
import 'package:exam_app/features/auth/api/data_source/auth_remote_datasource_impl.dart';
import 'package:exam_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:exam_app/features/auth/data/models/signup_response_model.dart';
import 'package:exam_app/features/auth/domain/models/signup_entity.dart';
import 'package:exam_app/features/auth/domain/models/signup_result_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_repository_impl_test.mocks.dart';


@GenerateMocks([AuthRemoteDatasourceImpl, AuthLocalDatasourceImpl])
void main() {
  late AuthRepoImpl repository;
  late MockAuthRemoteDatasourceImpl mockRemoteDataSource;
  late MockAuthLocalDatasourceImpl mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDatasourceImpl();
    mockLocalDataSource = MockAuthLocalDatasourceImpl();
    repository = AuthRepoImpl(authLocalDatasource: mockLocalDataSource, authRemoteDatasource: mockRemoteDataSource);
  });

  test('should return SignupResultEntity when call is successful', () async {
    final tSignupEntity = SignupEntity(
      firstName: 'Ahmed',
      lastName: 'Yousef',
      email: 'ahmed@example.com',
      password: 'Password123!',
      rePassword: 'Password123!',
      phone: '1234567890',
      userName: 'ahmedyousef',
    );

    final tSignupResponseModel = SignupResponseModel(
      message: 'Account created successfully',
      token: 'test_token_123',
    );

    final tSignupResultEntity = SignupResultEntity(
      message: 'Account created successfully',
      token: 'test_token_123',
    );

    when(mockRemoteDataSource.signup(any))
        .thenAnswer((_) async => tSignupResponseModel);

    final result = await repository.signup(tSignupEntity);

    expect(result, isA<Right<Failure, SignupResultEntity>>());
    result.fold(
      (failure) => fail('should not return failure'),
      (success) {
        expect(success.message, equals(tSignupResultEntity.message));
        expect(success.token, equals(tSignupResultEntity.token));
      },
    );
    verify(mockRemoteDataSource.signup(tSignupEntity)).called(1);
  });

  test('should return Failure when call fails', () async {
    final tSignupEntity = SignupEntity(
      firstName: 'Ahmed',
      lastName: 'Yousef',
      email: 'ahmed@example.com',
      password: 'Password123!',
      rePassword: 'Password123!',
      phone: '1234567890',
      userName: 'ahmedyousef',
    );

    when(mockRemoteDataSource.signup(any))
        .thenThrow(Exception('Network error'));

    final result = await repository.signup(tSignupEntity);

    expect(result, isA<Left<Failure, SignupResultEntity>>());
    verify(mockRemoteDataSource.signup(tSignupEntity)).called(1);
  });
}

