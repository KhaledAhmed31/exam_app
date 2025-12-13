import 'package:exam_app/features/profile/domain/entities/user_profile_entity.dart';
import 'package:exam_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<UserProfileEntity?> call() async {
    return await repository.getProfile();
  }
}
