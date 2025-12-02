import 'package:exam_app/features/profile/domain/entities/user_profile_entity.dart';

abstract class ProfileRepository {
  Future<UserProfileEntity?> getProfile();

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
