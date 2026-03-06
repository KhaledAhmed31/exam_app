import 'package:exam_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:exam_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:exam_app/features/profile/data/models/user_profile_model.dart';
import 'package:exam_app/features/profile/domain/entities/user_profile_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProfileRemoteDataSource>()])
void main() {
  late ProfileRepositoryImpl repository;
  late MockProfileRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockProfileRemoteDataSource();
    repository = ProfileRepositoryImpl(mockRemoteDataSource);
  });

  group('getProfile', () {
    test('should return UserProfileEntity when call is successful', () async {
      final tUserProfileModel = UserProfileModel(
        id: '1',
        username: 'testuser',
        firstName: 'Test',
        lastName: 'User',
        email: 'test@example.com',
        phone: '1234567890',
        profilePic: 'https://example.com/pic.jpg',
        isVerified: true,
      );

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

      when(
        mockRemoteDataSource.getProfile(),
      ).thenAnswer((_) async => tUserProfileModel);

      final result = await repository.getProfile();

      expect(result, equals(tUserProfileEntity));
      verify(mockRemoteDataSource.getProfile()).called(1);
    });

    test('should throw exception when call fails', () async {
      when(
        mockRemoteDataSource.getProfile(),
      ).thenThrow(Exception('Network error'));

      expect(() => repository.getProfile(), throwsException);
      verify(mockRemoteDataSource.getProfile()).called(1);
    });
  });

  group('editProfile', () {
    test('should return success message when call is successful', () async {
      const tSuccessMessage = 'Profile updated successfully';
      when(
        mockRemoteDataSource.editProfile(
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          email: anyNamed('email'),
          phone: anyNamed('phone'),
          username: anyNamed('username'),
        ),
      ).thenAnswer((_) async => tSuccessMessage);

      final result = await repository.editProfile(
        firstName: 'Updated',
        lastName: 'Name',
        email: 'updated@example.com',
        phone: '9876543210',
        username: 'updateduser',
      );

      expect(result, equals(tSuccessMessage));
      verify(
        mockRemoteDataSource.editProfile(
          firstName: 'Updated',
          lastName: 'Name',
          email: 'updated@example.com',
          phone: '9876543210',
          username: 'updateduser',
        ),
      ).called(1);
    });

    test('should throw exception when call fails', () async {
      when(
        mockRemoteDataSource.editProfile(
          firstName: anyNamed('firstName'),
          lastName: anyNamed('lastName'),
          email: anyNamed('email'),
          phone: anyNamed('phone'),
          username: anyNamed('username'),
        ),
      ).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(
        () => repository.editProfile(firstName: 'Updated'),
        throwsException,
      );
      verify(
        mockRemoteDataSource.editProfile(
          firstName: 'Updated',
          lastName: null,
          email: null,
          phone: null,
          username: null,
        ),
      ).called(1);
    });
  });

  group('changePassword', () {
    test('should return success message when call is successful', () async {
      const tSuccessMessage = 'Password changed successfully';
      when(
        mockRemoteDataSource.changePassword(
          oldPassword: anyNamed('oldPassword'),
          newPassword: anyNamed('newPassword'),
          confirmPassword: anyNamed('confirmPassword'),
        ),
      ).thenAnswer((_) async => tSuccessMessage);

      final result = await repository.changePassword(
        oldPassword: 'oldPass123',
        newPassword: 'newPass123',
        confirmPassword: 'newPass123',
      );

      expect(result, equals(tSuccessMessage));
      verify(
        mockRemoteDataSource.changePassword(
          oldPassword: 'oldPass123',
          newPassword: 'newPass123',
          confirmPassword: 'newPass123',
        ),
      ).called(1);
    });

    test('should throw exception when call fails', () async {
      when(
        mockRemoteDataSource.changePassword(
          oldPassword: anyNamed('oldPassword'),
          newPassword: anyNamed('newPassword'),
          confirmPassword: anyNamed('confirmPassword'),
        ),
      ).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(
        () => repository.changePassword(
          oldPassword: 'oldPass123',
          newPassword: 'newPass123',
          confirmPassword: 'newPass123',
        ),
        throwsException,
      );
      verify(
        mockRemoteDataSource.changePassword(
          oldPassword: 'oldPass123',
          newPassword: 'newPass123',
          confirmPassword: 'newPass123',
        ),
      ).called(1);
    });
  });
}
