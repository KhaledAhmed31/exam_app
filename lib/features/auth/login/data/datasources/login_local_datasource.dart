abstract class LoginLocalDatasource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
  Future<void> saveRememberMe(bool value);
}
