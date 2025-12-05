import 'package:dartz/dartz.dart';
import 'package:exam_app/core/shared/error/failure.dart';
import 'package:exam_app/features/signup/domain/entities/signup_entity.dart';
import 'package:exam_app/features/signup/domain/entities/signup_result_entity.dart';
import 'package:exam_app/features/signup/domain/repositories/signup_repository.dart';
import 'package:exam_app/features/signup/domain/usecases/signup_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SignupRepository>()])
void main() {
  late SignupUseCase useCase;
  late MockSignupRepository mockRepository;

  setUp(() {
    mockRepository = MockSignupRepository();
    useCase = SignupUseCase(repository: mockRepository);
  });

  test('should signup through repository', () async {
    final tSignupEntity = SignupEntity(
      firstName: 'Ahmed',
      lastName: 'Yousef',
      email: 'ahmed@example.com',
      password: 'Password123!',
      rePassword: 'Password123!',
      phone: '1234567890',
      userName: 'ahmedyousef',
    );

    final tSignupResultEntity = SignupResultEntity(
      message: 'Account created successfully',
      token: 'test_token_123',
    );

    when(mockRepository.signup(any))
        .thenAnswer((_) async => Right(tSignupResultEntity));

    final result = await useCase(tSignupEntity);

    expect(result, isA<Right<Failure, SignupResultEntity>>());
    result.fold(
      (failure) => fail('should not return failure'),
      (success) {
        expect(success.message, equals(tSignupResultEntity.message));
        expect(success.token, equals(tSignupResultEntity.token));
      },
    );
    verify(mockRepository.signup(tSignupEntity)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}

