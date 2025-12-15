import 'package:dio/dio.dart';
import 'package:exam_app/features/auth/api/clients/auth_api_client.dart';
import 'package:exam_app/features/auth/api/data_source/auth_remote_datasource_impl.dart';
import 'package:exam_app/features/auth/data/data_source/auth_remote_datasource.dart';
import 'package:exam_app/features/auth/data/models/signup_response_model.dart';
import 'package:exam_app/features/auth/domain/models/signup_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([Dio, AuthApiClient])
void main() {
  late AuthRemoteDatasource dataSource;
  late MockDio mockDio;
  late MockAuthApiClient mockApiClient;

  setUp(() {
    mockDio = MockDio();
    mockApiClient = MockAuthApiClient();
    dataSource = AuthRemoteDatasourceImpl(mockApiClient, mockDio);
  });

  test('should return SignupResponseModel when call is successful', () async {
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

    when(mockDio.post(any, data: anyNamed('data'))).thenAnswer(
      (_) async => Response(
        data: {
          'message': 'Account created successfully',
          'token': 'test_token_123',
        },
        statusCode: 201,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final result = await dataSource.signup(tSignupEntity);

    expect(result.message, equals(tSignupResponseModel.message));
    expect(result.token, equals(tSignupResponseModel.token));
    verify(mockDio.post(any, data: anyNamed('data'))).called(1);
  });

  test('should throw exception when call fails', () async {
    final tSignupEntity = SignupEntity(
      firstName: 'Ahmed',
      lastName: 'Yousef',
      email: 'ahmed@example.com',
      password: 'Password123!',
      rePassword: 'Password123!',
      phone: '1234567890',
      userName: 'ahmedyousef',
    );

    when(mockDio.post(any, data: anyNamed('data'))).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionError,
      ),
    );

    expect(() => dataSource.signup(tSignupEntity), throwsException);
    verify(mockDio.post(any, data: anyNamed('data'))).called(1);
  });
}
