import 'package:exam_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUseCase {
  final ProfileRepository repository;

  EditProfileUseCase(this.repository);

  Future<String> call({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? username,
  }) async {
    return await repository.editProfile(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      username: username,
    );
  }
}
