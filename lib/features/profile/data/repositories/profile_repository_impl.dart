import 'package:exam_app/core/config/error/error_handler.dart';
import 'package:exam_app/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:exam_app/features/profile/domain/entities/user_profile_entity.dart';
import 'package:exam_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserProfileEntity?> getProfile() async {
    try {
      final model = await remoteDataSource.getProfile();
      return model.toEntity();
    } catch (error) {
      ErrorHandler.handle(error);
      rethrow;
    }
  }

  @override
  Future<String> editProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? username,
  }) async {
    try {
      return await remoteDataSource.editProfile(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        username: username,
      );
    } catch (error) {
      ErrorHandler.handle(error);
      rethrow;
    }
  }

  @override
  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      return await remoteDataSource.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
    } catch (error) {
      ErrorHandler.handle(error);
      rethrow;
    }
  }
}
