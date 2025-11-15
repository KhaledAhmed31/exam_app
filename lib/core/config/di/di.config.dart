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

import '../../../features/auth/forget_password/api/clients/reset_password_client.dart'
    as _i672;
import '../../../features/auth/forget_password/api/clients/send_reset_code_client.dart'
    as _i183;
import '../../../features/auth/forget_password/api/clients/verify_reset_code_client.dart'
    as _i779;
import '../../../features/auth/forget_password/api/data_source/send_reset_code_data_suorce_impl.dart'
    as _i849;
import '../../../features/auth/forget_password/data/data_source/forget_password_data_suorce.dart'
    as _i126;
import '../../../features/auth/forget_password/data/repositories/forget_password_repo_impl.dart'
    as _i704;
import '../../../features/auth/forget_password/domain/repositories/forgetpassword_repo.dart'
    as _i233;
import '../../../features/auth/forget_password/domain/usecases/reset_password_use_case.dart'
    as _i934;
import '../../../features/auth/forget_password/domain/usecases/send_reset_code_use_case.dart'
    as _i484;
import '../../../features/auth/forget_password/domain/usecases/verify_reset_code_use_case.dart'
    as _i614;
import '../../../features/auth/forget_password/presentation/bloc/forget_password_bloc.dart'
    as _i588;
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
import '../../../features/auth/login/domain/usecases/is_loggedin_usecase.dart'
    as _i115;
import '../../../features/auth/login/domain/usecases/login_uescase.dart'
    as _i442;
import '../../../features/auth/login/presentation/bloc/auth_view_model.dart'
    as _i946;
import '../../../features/explore/api/clients/get_all_subject_client.dart'
    as _i473;
import '../../../features/explore/api/data_source/get_all_subjects_data_source_impl.dart'
    as _i323;
import '../../../features/explore/data/datasources/get_all_subjects_data_source.dart'
    as _i460;
import '../../../features/explore/data/repositories/get_all_subjects_repo_impl.dart'
    as _i311;
import '../../../features/explore/domain/repositories/get_all_subjects_repo.dart'
    as _i234;
import '../../../features/explore/domain/usecases/get_all_subjects_use_case.dart'
    as _i109;
import '../../../features/explore/presentation/bloc/explore_bloc.dart' as _i376;
import '../../shared/presentation/bloc/localization/localization_bloc.dart'
    as _i556;
import 'dio_modules.dart' as _i291;
import 'secure_storage_module.dart' as _i897;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final secureStorageModule = _$SecureStorageModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => secureStorageModule.secureStorage,
    );
    gh.lazySingleton<_i556.LocalizationBloc>(() => _i556.LocalizationBloc());
    gh.singleton<_i918.LoginLocalDatasource>(
      () => _i670.LoginLocalDatasourceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i672.ResetPasswordClient>(
      () => _i672.ResetPasswordClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i183.SendResetCodeClient>(
      () => _i183.SendResetCodeClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i779.VerifyResetCodeClient>(
      () => _i779.VerifyResetCodeClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i473.GetAllSubjectClient>(
      () => _i473.GetAllSubjectClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i463.LoginApiClient>(
      () => _i463.LoginApiClient(gh<_i361.Dio>()),
    );
    gh.singleton<_i1056.LoginRemoteDatasource>(
      () => _i129.LoginRemoteDatasourceImpl(gh<_i463.LoginApiClient>()),
    );
    gh.lazySingleton<_i126.ForgetPassordDataSource>(
      () => _i849.SendResetCodeDataSuorceImpl(
        gh<_i672.ResetPasswordClient>(),
        gh<_i183.SendResetCodeClient>(),
        gh<_i779.VerifyResetCodeClient>(),
      ),
    );
    gh.lazySingleton<_i460.GetAllSubjectsDataSource>(
      () => _i323.GetAllSubjectsDataSourceImpl(gh<_i473.GetAllSubjectClient>()),
    );
    gh.lazySingleton<_i233.ForgetPawwordRepo>(
      () => _i704.ForgetPasswordRepoImpl(
        forgetPasswordDataSource: gh<_i126.ForgetPassordDataSource>(),
      ),
    );
    gh.lazySingleton<_i234.GetAllSubjectsRepo>(
      () => _i311.GetAllSubjectsRepoImpl(gh<_i460.GetAllSubjectsDataSource>()),
    );
    gh.singleton<_i142.LoginRepo>(
      () => _i226.LoginRepoImpl(
        gh<_i1056.LoginRemoteDatasource>(),
        gh<_i918.LoginLocalDatasource>(),
      ),
    );
    gh.singleton<_i115.IsLoggedInUsecase>(
      () => _i115.IsLoggedInUsecase(loginRepo: gh<_i142.LoginRepo>()),
    );
    gh.singleton<_i442.LoginUescase>(
      () => _i442.LoginUescase(gh<_i142.LoginRepo>()),
    );
    gh.factory<_i946.AuthViewModel>(
      () => _i946.AuthViewModel(
        gh<_i442.LoginUescase>(),
        gh<_i115.IsLoggedInUsecase>(),
      ),
    );
    gh.lazySingleton<_i484.SendResetCodeUseCase>(
      () => _i484.SendResetCodeUseCase(
        sendRestCodeRepo: gh<_i233.ForgetPawwordRepo>(),
      ),
    );
    gh.lazySingleton<_i934.ResetPasswordUseCase>(
      () => _i934.ResetPasswordUseCase(gh<_i233.ForgetPawwordRepo>()),
    );
    gh.lazySingleton<_i614.VerifyResetCodeUseCase>(
      () => _i614.VerifyResetCodeUseCase(gh<_i233.ForgetPawwordRepo>()),
    );
    gh.lazySingleton<_i109.GetAllSubjectsUseCase>(
      () => _i109.GetAllSubjectsUseCase(gh<_i234.GetAllSubjectsRepo>()),
    );
    gh.lazySingleton<_i376.GetallSubjectsBloc>(
      () => _i376.GetallSubjectsBloc(gh<_i109.GetAllSubjectsUseCase>()),
    );
    gh.lazySingleton<_i588.ForgetPasswordBloc>(
      () => _i588.ForgetPasswordBloc(
        gh<_i484.SendResetCodeUseCase>(),
        gh<_i614.VerifyResetCodeUseCase>(),
        gh<_i934.ResetPasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}

class _$SecureStorageModule extends _i897.SecureStorageModule {}
