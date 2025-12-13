import 'package:exam_app/features/profile/domain/entities/user_profile_entity.dart';
import 'package:exam_app/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:exam_app/features/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:exam_app/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:exam_app/features/profile/view_model/profile_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_cubit_test.mocks.dart';

@GenerateMocks([GetProfileUseCase, EditProfileUseCase, ChangePasswordUseCase])
void main() {
  late ProfileCubit profileCubit;
  late MockGetProfileUseCase mockGetProfileUseCase;
  late MockEditProfileUseCase mockEditProfileUseCase;
  late MockChangePasswordUseCase mockChangePasswordUseCase;

  setUp(() {
    mockGetProfileUseCase = MockGetProfileUseCase();
    mockEditProfileUseCase = MockEditProfileUseCase();
    mockChangePasswordUseCase = MockChangePasswordUseCase();
    profileCubit = ProfileCubit(
      mockGetProfileUseCase,
      mockEditProfileUseCase,
      mockChangePasswordUseCase,
    );
  });

  tearDown(() {
    profileCubit.close();
  });

  test('ProfileCubit initial state should be ProfileState', () {
    expect(profileCubit.state, equals(const ProfileState()));
  });

  group('loadProfile', () {
    test('should emit loading state then success state with profile', () async {
      final tUserProfileEntity = UserProfileEntity(
        id: '1',
        username: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@example.com',
        phone: '1234567890',
        profilePic: 'https://example.com/pic.jpg',
        isVerified: true,
      );

      when(mockGetProfileUseCase()).thenAnswer((_) async => tUserProfileEntity);

      await profileCubit.loadProfile();

      expect(profileCubit.state.profile, equals(tUserProfileEntity));
      expect(profileCubit.state.isLoading, isFalse);
      verify(mockGetProfileUseCase()).called(1);
    });

    test(
      'should emit loading state then error state when call fails',
      () async {
        when(mockGetProfileUseCase()).thenThrow(Exception('Network error'));

        await profileCubit.loadProfile();

        expect(profileCubit.state.isLoading, isFalse);
        expect(profileCubit.state.errorMessage, contains('Network error'));
        verify(mockGetProfileUseCase()).called(1);
      },
    );
  });

  group('updateProfile', () {
    test(
      'should emit updating state then success state with updated profile',
      () async {
        final tUserProfileEntity = UserProfileEntity(
          id: '1',
          username: 'updateduser',
          firstName: 'Updated',
          lastName: 'Name',
          email: 'updated@example.com',
          phone: '9876543210',
          isVerified: true,
        );

        const tSuccessMessage = 'Profile updated successfully';

        when(
          mockEditProfileUseCase(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            phone: anyNamed('phone'),
            username: anyNamed('username'),
          ),
        ).thenAnswer((_) async => tSuccessMessage);

        when(
          mockGetProfileUseCase(),
        ).thenAnswer((_) async => tUserProfileEntity);

        await profileCubit.updateProfile(
          firstName: 'Updated',
          lastName: 'Name',
          email: 'updated@example.com',
          phone: '9876543210',
          username: 'updateduser',
        );

        expect(profileCubit.state.profile, equals(tUserProfileEntity));
        expect(profileCubit.state.isUpdating, isFalse);
        expect(profileCubit.state.successMessage, equals(tSuccessMessage));
        verify(
          mockEditProfileUseCase(
            firstName: 'Updated',
            lastName: 'Name',
            email: 'updated@example.com',
            phone: '9876543210',
            username: 'updateduser',
          ),
        ).called(1);
        verify(mockGetProfileUseCase()).called(1);
      },
    );

    test(
      'should emit updating state then error state when call fails',
      () async {
        when(
          mockEditProfileUseCase(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            phone: anyNamed('phone'),
            username: anyNamed('username'),
          ),
        ).thenThrow(Exception('Network error'));

        await profileCubit.updateProfile(firstName: 'Updated');

        expect(profileCubit.state.isUpdating, isFalse);
        expect(profileCubit.state.errorMessage, contains('Network error'));
        verify(
          mockEditProfileUseCase(
            firstName: 'Updated',
            lastName: null,
            email: null,
            phone: null,
            username: null,
          ),
        ).called(1);
      },
    );
  });

  group('changePassword', () {
    test('should emit changing password state then success state', () async {
      const tSuccessMessage = 'Password changed successfully';

      when(
        mockChangePasswordUseCase(
          oldPassword: anyNamed('oldPassword'),
          newPassword: anyNamed('newPassword'),
          confirmPassword: anyNamed('confirmPassword'),
        ),
      ).thenAnswer((_) async => tSuccessMessage);

      await profileCubit.changePassword(
        oldPassword: 'oldPass123',
        newPassword: 'newPass123',
        confirmPassword: 'newPass123',
      );

      // Assert
      expect(profileCubit.state.isChangingPassword, isFalse);
      expect(profileCubit.state.successMessage, equals(tSuccessMessage));
      verify(
        mockChangePasswordUseCase(
          oldPassword: 'oldPass123',
          newPassword: 'newPass123',
          confirmPassword: 'newPass123',
        ),
      ).called(1);
    });

    test(
      'should emit changing password state then error state when call fails',
      () async {
        when(
          mockChangePasswordUseCase(
            oldPassword: anyNamed('oldPassword'),
            newPassword: anyNamed('newPassword'),
            confirmPassword: anyNamed('confirmPassword'),
          ),
        ).thenThrow(Exception('Invalid password'));

        await profileCubit.changePassword(
          oldPassword: 'oldPass123',
          newPassword: 'newPass123',
          confirmPassword: 'newPass123',
        );

        // Assert
        expect(profileCubit.state.isChangingPassword, isFalse);
        expect(profileCubit.state.errorMessage, contains('Invalid password'));
        verify(
          mockChangePasswordUseCase(
            oldPassword: 'oldPass123',
            newPassword: 'newPass123',
            confirmPassword: 'newPass123',
          ),
        ).called(1);
      },
    );
  });

  group('selectImage', () {
    test('should emit state with selected image path', () {
      const tImagePath = '/path/to/image.jpg';

      profileCubit.selectImage(tImagePath);

      expect(
        profileCubit.state,
        equals(const ProfileState(selectedImagePath: tImagePath)),
      );
    });
  });

  group('clearError', () {
    test('should clear error message', () {
      profileCubit.emit(const ProfileState(errorMessage: 'Some error'));

      profileCubit.clearError();

      expect(profileCubit.state.errorMessage, isNull);
    });
  });

  group('clearSuccess', () {
    test('should clear success message', () {
      profileCubit.emit(const ProfileState(successMessage: 'Success message'));

      profileCubit.clearSuccess();

      expect(profileCubit.state.successMessage, isNull);
    });
  });
}
