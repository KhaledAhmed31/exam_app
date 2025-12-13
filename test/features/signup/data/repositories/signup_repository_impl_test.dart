import 'package:dartz/dartz.dart';
import 'package:exam_app/core/shared/error/failure.dart';
import 'package:exam_app/features/signup/data/datasources/signup_remote_data_source.dart';
import 'package:exam_app/features/signup/data/repositories/signup_repository_impl.dart';
import 'package:exam_app/features/signup/data/models/signup_response_model.dart';
import 'package:exam_app/features/signup/domain/entities/signup_entity.dart';
import 'package:exam_app/features/signup/domain/entities/signup_result_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SignupRemoteDataSource>()])
void main() {
  late SignupRepositoryImpl repository;
  late MockSignupRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockSignupRemoteDataSource();
    repository = SignupRepositoryImpl(remoteDataSource: mockRemoteDataSource);
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

