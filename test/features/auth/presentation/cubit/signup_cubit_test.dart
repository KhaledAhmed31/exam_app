import 'package:dartz/dartz.dart';
import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/auth/domain/models/signup_result_entity.dart';
import 'package:exam_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:exam_app/features/auth/presentation/bloc/signup_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_cubit_test.mocks.dart';

@GenerateMocks([SignupUseCase])
void main() {
  late SignupCubit signupCubit;
  late MockSignupUseCase mockSignupUseCase;

  setUp(() {
    mockSignupUseCase = MockSignupUseCase();
    signupCubit = SignupCubit(mockSignupUseCase);
  });

  tearDown(() {
    signupCubit.close();
  });

  test('SignupCubit initial state should be SignupInitial', () {
    expect(signupCubit.state, equals(SignupInitial()));
  });

  group('signup', () {
    test('should emit loading state then success state', () async {
      final tSignupResultEntity = SignupResultEntity(
        message: 'Account created successfully',
        token: 'test_token_123',
      );

      when(
        mockSignupUseCase(any),
      ).thenAnswer((_) async => Right(tSignupResultEntity));

      await signupCubit.signup(
        firstName: 'Ahmed',
        lastName: 'Yousef',
        email: 'ahmed@example.com',
        password: 'Password123!',
        rePassword: 'Password123!',
        phone: '1234567890',
        userName: 'ahmedyousef',
      );

      expect(signupCubit.state, isA<SignupSuccess>());
      final successState = signupCubit.state as SignupSuccess;
      expect(
        successState.signupResult.message,
        equals(tSignupResultEntity.message),
      );
      expect(
        successState.signupResult.token,
        equals(tSignupResultEntity.token),
      );
      verify(mockSignupUseCase(any)).called(1);
    });

    test(
      'should emit loading state then error state when call fails',
      () async {
        when(mockSignupUseCase(any)).thenAnswer(
          (_) async => Left(
            Failure(
              statusCode: -1,
              message: 'Network error',
              success: false,
              status: 0,
            ),
          ),
        );

        await signupCubit.signup(
          firstName: 'Ahmed',
          lastName: 'Yousef',
          email: 'ahmed@example.com',
          password: 'Password123!',
          rePassword: 'Password123!',
          phone: '1234567890',
          userName: 'ahmedyousef',
        );

        expect(signupCubit.state, isA<SignupError>());
        final errorState = signupCubit.state as SignupError;
        expect(errorState.message, equals('Network error'));
        verify(mockSignupUseCase(any)).called(1);
      },
    );
  });
}
