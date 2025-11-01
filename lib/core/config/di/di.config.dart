// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../features/auth/login/api/api_client/login_api_client.dart'
    as _i463;
import '../../../features/auth/login/api/datasources/login_local_datasource_impl.dart'
    as _i670;
import '../../../features/auth/login/api/datasources/login_remote_datasource_impl.dart'
    as _i129;
import '../../../features/auth/login/data/datasources/login_local_datasource.dart'
    as _i918;
import '../../../features/auth/login/data/datasources/login_remote_datasource.dart'
    as _i1056;
import '../../../features/auth/login/data/repos/login_repo_impl.dart' as _i226;
import '../../../features/auth/login/domain/repos/login_repo.dart' as _i142;
import '../../../features/auth/login/domain/usecases/login_uescase.dart'
    as _i442;
import '../../../features/auth/login/presentation/view_model/auth_view_model.dart'
    as _i410;
import 'di_modules.dart' as _i176;
import 'flutter_secure_storage_module.dart' as _i319;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final secureStorageModule = _$SecureStorageModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => secureStorageModule.secureStorage,
    );
    gh.singleton<_i918.LoginLocalDatasource>(
      () => _i670.LoginLocalDatasourceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.singleton<_i463.LoginApiClient>(
      () => _i463.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i1056.LoginRemoteDatasource>(
      () => _i129.LoginRemoteDatasourceImpl(gh<_i463.LoginApiClient>()),
    );
    gh.singleton<_i142.LoginRepo>(
      () => _i226.LoginRepoImpl(
        gh<_i1056.LoginRemoteDatasource>(),
        gh<_i918.LoginLocalDatasource>(),
      ),
    );
    gh.singleton<_i442.LoginUescase>(
      () => _i442.LoginUescase(gh<_i142.LoginRepo>()),
    );
    gh.singleton<_i410.AuthViewModel>(
      () => _i410.AuthViewModel(gh<_i442.LoginUescase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i176.RegisterModule {}

class _$SecureStorageModule extends _i319.SecureStorageModule {}
