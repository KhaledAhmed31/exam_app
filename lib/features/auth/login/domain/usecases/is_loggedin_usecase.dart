import 'package:exam_app/features/auth/login/domain/repos/login_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class IsLoggedInUsecase {
  final LoginRepo loginRepo;
  IsLoggedInUsecase({required this.loginRepo});

  Future<bool> call() => loginRepo.isLoggedIn();
}
