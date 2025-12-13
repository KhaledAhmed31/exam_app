import 'package:exam_app/features/profile/data/models/user_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileModel> getProfile();

  Future<String> editProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? username,
  });

  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
