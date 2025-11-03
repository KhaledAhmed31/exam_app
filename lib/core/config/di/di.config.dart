// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
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
import '../../shared/presentation/bloc/localization/localization_bloc.dart'
    as _i556;
import 'di_modules.dart' as _i176;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i556.LocalizationBloc>(() => _i556.LocalizationBloc());
    gh.lazySingleton<_i672.ResetPasswordClient>(
      () => _i672.ResetPasswordClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i183.SendResetCodeClient>(
      () => _i183.SendResetCodeClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i779.VerifyResetCodeClient>(
      () => _i779.VerifyResetCodeClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i126.ForgetPassordDataSource>(
      () => _i849.SendResetCodeDataSuorceImpl(
        gh<_i672.ResetPasswordClient>(),
        gh<_i183.SendResetCodeClient>(),
        gh<_i779.VerifyResetCodeClient>(),
      ),
    );
    gh.lazySingleton<_i233.ForgetPawwordRepo>(
      () => _i704.ForgetPasswordRepoImpl(
        forgetPasswordDataSource: gh<_i126.ForgetPassordDataSource>(),
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

class _$RegisterModule extends _i176.RegisterModule {}
