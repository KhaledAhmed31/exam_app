import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../api/api_const.dart';

@module
abstract class RegisterModule {
  @lazySingleton
   Dio get dio {
    Dio dioObject = Dio(
      BaseOptions(
        baseUrl: ApiConsts.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
      ),
    );
    dioObject.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final FlutterSecureStorage secureStorage = FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
          );

          String? authToken = await secureStorage.read(key: 'auth_token');
          if (authToken != null) {
            options.headers['token'] = authToken;
          }

          return handler.next(options);
        },
      ),
    );
    return dioObject;
  }
}
