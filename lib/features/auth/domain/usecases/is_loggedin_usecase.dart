import 'package:exam_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class IsLoggedInUsecase {
  final AuthRepo loginRepo;
  IsLoggedInUsecase({required this.loginRepo});

  Future<bool> call() => loginRepo.isLoggedIn();
}
