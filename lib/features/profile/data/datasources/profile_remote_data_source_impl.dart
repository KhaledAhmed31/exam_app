import 'package:exam_app/features/profile/data/datasources/profile_api_client.dart';
import 'package:injectable/injectable.dart';
import '../models/user_profile_model.dart';
import 'profile_remote_data_source.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiClient apiClient;

  ProfileRemoteDataSourceImpl(this.apiClient);

  @override
  Future<UserProfileModel> getProfile() async {
    return await apiClient.getProfile();
  }

  @override
  Future<String> editProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? username,
  }) async {
    final body = <String, dynamic>{};
    if (firstName != null) body['firstName'] = firstName;
    if (lastName != null) body['lastName'] = lastName;
    if (email != null) body['email'] = email;
    if (phone != null) body['phone'] = phone;
    if (username != null) body['username'] = username;

    await apiClient.editProfile(body);
    return 'Profile updated successfully';
  }

  @override
  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final body = {
      'oldPassword': oldPassword,
      'password': newPassword,
      'rePassword': confirmPassword,
    };

    await apiClient.changePassword(body);
    return 'Password changed successfully';
  }
}
