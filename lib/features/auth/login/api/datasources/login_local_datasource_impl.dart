import 'package:exam_app/features/auth/login/data/datasources/login_local_datasource.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: LoginLocalDatasource)
class LoginLocalDatasourceImpl implements LoginLocalDatasource {
  final FlutterSecureStorage secureStorage;
  LoginLocalDatasourceImpl(this.secureStorage);
  static const String _tokenKey = 'auth_token';

  @override
  Future<void> saveToken(String token) async {
    try {
      await secureStorage.write(
        key: _tokenKey,
        value: token,
        aOptions: _getAndroidOptions(),
      );
    } catch (e) {
      throw Exception('Failed to save token: $e');
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await secureStorage.read(
        key: _tokenKey,
        aOptions: _getAndroidOptions(),
      );
    } catch (e) {
      throw Exception('Failed to get token: $e');
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      await secureStorage.delete(
        key: _tokenKey,
        aOptions: _getAndroidOptions(),
      );
    } catch (e) {
      throw Exception('Failed to delete token: $e');
    }
  }

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);
}
