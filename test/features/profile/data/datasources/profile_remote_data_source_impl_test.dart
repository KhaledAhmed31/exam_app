import 'package:exam_app/features/profile/data/datasources/profile_api_client.dart';
import 'package:exam_app/features/profile/data/datasources/profile_remote_data_source_impl.dart';
import 'package:exam_app/features/profile/data/models/user_profile_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_data_source_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProfileApiClient>()])
void main() {
  late ProfileRemoteDataSourceImpl dataSource;
  late MockProfileApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockProfileApiClient();
    dataSource = ProfileRemoteDataSourceImpl(mockApiClient);
  });

  group('getProfile', () {
    test('should return UserProfileModel when call is successful', () async {
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

      when(
        mockApiClient.getProfile(),
      ).thenAnswer((_) async => tUserProfileModel);

      final result = await dataSource.getProfile();

      expect(result, equals(tUserProfileModel));
      verify(mockApiClient.getProfile()).called(1);
    });

    test('should throw exception when call fails', () async {
      when(mockApiClient.getProfile()).thenThrow(Exception('Network error'));

      expect(() => dataSource.getProfile(), throwsException);
      verify(mockApiClient.getProfile()).called(1);
    });
  });

  group('editProfile', () {
    test('should return success message when call is successful', () async {
      when(
        mockApiClient.editProfile(any),
      ).thenAnswer((_) async => Future.value());

      final result = await dataSource.editProfile(
        firstName: 'Updated',
        lastName: 'Name',
        email: 'updated@example.com',
        phone: '9876543210',
        username: 'updateduser',
      );

      expect(result, equals('Profile updated successfully'));
      verify(mockApiClient.editProfile(any)).called(1);
    });

    test('should throw exception when call fails', () async {
      when(
        mockApiClient.editProfile(any),
      ).thenThrow(Exception('Network error'));

      expect(
        () => dataSource.editProfile(firstName: 'Updated'),
        throwsException,
      );
      verify(mockApiClient.editProfile(any)).called(1);
    });
  });

  group('changePassword', () {
    test('should return success message when call is successful', () async {
      when(
        mockApiClient.changePassword(any),
      ).thenAnswer((_) async => Future.value());

      final result = await dataSource.changePassword(
        oldPassword: 'oldPass123',
        newPassword: 'newPass123',
        confirmPassword: 'newPass123',
      );

      expect(result, equals('Password changed successfully'));
      verify(mockApiClient.changePassword(any)).called(1);
    });

    test('should throw exception when call fails', () async {
      when(
        mockApiClient.changePassword(any),
      ).thenThrow(Exception('Network error'));

      expect(
        () => dataSource.changePassword(
          oldPassword: 'oldPass123',
          newPassword: 'newPass123',
          confirmPassword: 'newPass123',
        ),
        throwsException,
      );
      verify(mockApiClient.changePassword(any)).called(1);
    });
  });
}
