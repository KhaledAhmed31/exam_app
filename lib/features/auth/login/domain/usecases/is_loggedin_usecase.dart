import '../repos/login_repo.dart';
import 'package:injectable/injectable.dart';

@singleton
class IsLoggedInUsecase {
  final LoginRepo loginRepo;

  IsLoggedInUsecase({required this.loginRepo});

  Future<bool> call() async {
    bool isLoggedIn = await loginRepo.isLoggedIn();
    return isLoggedIn;
  }
}
