// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

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
import 'package:sqflite/sqflite.dart' as _i779;

import '../../../features/auth/api/clients/auth_api_client.dart' as _i748;
import '../../../features/auth/api/data_source/auth_local_datasource_impl.dart'
    as _i997;
import '../../../features/auth/api/data_source/auth_remote_datasource_impl.dart'
    as _i102;
import '../../../features/auth/data/data_source/auth_local_datasource.dart'
    as _i438;
import '../../../features/auth/data/data_source/auth_remote_datasource.dart'
    as _i507;
import '../../../features/auth/data/repositories/auth_repo_impl.dart' as _i858;
import '../../../features/auth/domain/repositories/auth_repo.dart' as _i519;
import '../../../features/auth/domain/usecases/is_loggedin_usecase.dart'
    as _i655;
import '../../../features/auth/domain/usecases/login_uescase.dart' as _i307;
import '../../../features/auth/domain/usecases/reset_password_use_case.dart'
    as _i187;
import '../../../features/auth/domain/usecases/send_reset_code_use_case.dart'
    as _i152;
import '../../../features/auth/domain/usecases/signup_usecase.dart' as _i754;
import '../../../features/auth/domain/usecases/verify_reset_code_use_case.dart'
    as _i711;
import '../../../features/auth/presentation/bloc/auth_view_model.dart' as _i985;
import '../../../features/auth/presentation/bloc/forget_password_bloc.dart'
    as _i324;
import '../../../features/auth/presentation/bloc/signup_cubit.dart' as _i718;
import '../../../features/exams_page/api/api_client/exam_questions_api_client.dart'
    as _i184;
import '../../../features/exams_page/api/datasources/get_exam_questions_remote_datasource_impl.dart'
    as _i18;
import '../../../features/exams_page/data/datasources/get_exam_questions_remote_datasource.dart'
    as _i1060;
import '../../../features/exams_page/data/repos/get_exam_questions_repo_impl.dart'
    as _i58;
import '../../../features/exams_page/domain/repos/get_exam_questions_repo.dart'
    as _i366;
import '../../../features/exams_page/domain/usecases/get_exam_questions_usecase.dart'
    as _i971;
import '../../../features/exams_page/presentation/bloc/exam_page_bloc.dart'
    as _i563;
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
import '../../../features/profile/data/datasources/profile_api_client.dart'
    as _i211;
import '../../../features/profile/data/datasources/profile_remote_data_source.dart'
    as _i214;
import '../../../features/profile/data/datasources/profile_remote_data_source_impl.dart'
    as _i915;
import '../../../features/profile/data/repositories/profile_repository_impl.dart'
    as _i695;
import '../../../features/profile/domain/repositories/profile_repository.dart'
    as _i919;
import '../../../features/profile/domain/usecases/change_password_usecase.dart'
    as _i533;
import '../../../features/profile/domain/usecases/edit_profile_usecase.dart'
    as _i221;
import '../../../features/profile/domain/usecases/get_profile_usecase.dart'
    as _i248;
import '../../../features/profile/view_model/profile_cubit.dart' as _i990;
import '../../../features/results_tap/data/datasources/exam_results_data_source.dart'
    as _i498;
import '../../../features/results_tap/data/repositories/results_history_repo_impl.dart'
    as _i519;
import '../../../features/results_tap/domain/repositories/results_history_repo.dart'
    as _i132;
import '../../../features/results_tap/domain/usecases/get_results_history_use_case.dart'
    as _i997;
import '../../../features/results_tap/domain/usecases/save_results_history_use_case.dart'
    as _i376;
import '../../../features/results_tap/presentation/bloc/results_history_bloc.dart'
    as _i598;
import '../../../features/subject%20details/api/clients/get_exams_on_subjects_client.dart'
    as _i822;
import '../../../features/subject%20details/api/data_source/get_exams_on_subject_data_source_imp.dart'
    as _i64;
import '../../../features/subject%20details/data/datasources/get_exams_on_subject_remote_data_source.dart'
    as _i88;
import '../../../features/subject%20details/data/repositories/get_exams_on_subject_repo_impl.dart'
    as _i576;
import '../../../features/subject%20details/domain/repositories/get_exams_on_subject_repo.dart'
    as _i478;
import '../../../features/subject%20details/domain/usecases/get_exams_on_subjects_use_case.dart'
    as _i517;
import '../../../features/subject%20details/presentation/bloc/subject_details_bloc.dart'
    as _i1044;
import '../../shared/presentation/bloc/localization/localization_bloc.dart'
    as _i556;
import 'db_module.dart' as _i982;
import 'di_modules.dart' as _i176;
import 'flutter_secure_storage_module.dart' as _i319;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dbModule = _$DbModule();
    final registerModule = _$RegisterModule();
    final secureStorageModule = _$SecureStorageModule();
    await gh.factoryAsync<_i779.Database>(
      () => dbModule.initDb,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => secureStorageModule.secureStorage,
    );
    gh.lazySingleton<_i556.LocalizationBloc>(() => _i556.LocalizationBloc());
    gh.lazySingleton<_i498.ExamResultsDataSource>(
      () => _i498.ExamResultsDataSource(db: gh<_i779.Database>()),
    );
    gh.factory<_i438.AuthLocalDatasource>(
      () => _i997.AuthLocalDatasourceImpl(),
    );
    gh.lazySingleton<_i748.AuthApiClient>(
      () => _i748.AuthApiClient.new(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i473.GetAllSubjectClient>(
      () => _i473.GetAllSubjectClient.new(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i211.ProfileApiClient>(
      () => _i211.ProfileApiClient.new(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i822.GetExamsOnSubjectsClient>(
      () => _i822.GetExamsOnSubjectsClient.new(gh<_i361.Dio>()),
    );
    gh.factory<_i184.ExamQuestionsApiClient>(
      () => _i184.ExamQuestionsApiClient.new(gh<_i361.Dio>()),
    );
    gh.factory<_i507.AuthRemoteDatasource>(
      () => _i102.AuthRemoteDatasourceImpl(
        gh<_i748.AuthApiClient>(),
        gh<_i361.Dio>(),
      ),
    );
    gh.lazySingleton<_i132.ResultsHistoryRepo>(
      () => _i519.ResultsHistoryRepoImpl(gh<_i498.ExamResultsDataSource>()),
    );
    gh.lazySingleton<_i997.GetResultsHistoryUseCase>(
      () => _i997.GetResultsHistoryUseCase(
        resultsHistoryRepo: gh<_i132.ResultsHistoryRepo>(),
      ),
    );
    gh.lazySingleton<_i376.SaveResultsHistoryUseCase>(
      () => _i376.SaveResultsHistoryUseCase(
        resultsHistoryRepo: gh<_i132.ResultsHistoryRepo>(),
      ),
    );
    gh.lazySingleton<_i598.ResultsHistoryBloc>(
      () => _i598.ResultsHistoryBloc(
        getResultsHistoryUseCase: gh<_i997.GetResultsHistoryUseCase>(),
        saveResultsHistoryUseCase: gh<_i376.SaveResultsHistoryUseCase>(),
      ),
    );
    gh.factory<_i214.ProfileRemoteDataSource>(
      () => _i915.ProfileRemoteDataSourceImpl(gh<_i211.ProfileApiClient>()),
    );
    gh.factory<_i1060.GetExamQuestionsRemoteDatasource>(
      () => _i18.GetExamQuestionsRemoteDatasourceImpl(
        gh<_i184.ExamQuestionsApiClient>(),
      ),
    );
    gh.factory<_i366.GetExamQuestionsRepo>(
      () => _i58.GetExamQuestionsRepoImpl(
        gh<_i1060.GetExamQuestionsRemoteDatasource>(),
      ),
    );
    gh.lazySingleton<_i460.GetAllSubjectsDataSource>(
      () => _i323.GetAllSubjectsDataSourceImpl(gh<_i473.GetAllSubjectClient>()),
    );
    gh.factory<_i519.AuthRepo>(
      () => _i858.AuthRepoImpl(
        authRemoteDatasource: gh<_i507.AuthRemoteDatasource>(),
        authLocalDatasource: gh<_i438.AuthLocalDatasource>(),
      ),
    );
    gh.lazySingleton<_i234.GetAllSubjectsRepo>(
      () => _i311.GetAllSubjectsRepoImpl(gh<_i460.GetAllSubjectsDataSource>()),
    );
    gh.lazySingleton<_i88.GetExamsOnSubjectRemoteDataSource>(
      () => _i64.GetExamsOnSubjectDataSourceImp(
        gh<_i822.GetExamsOnSubjectsClient>(),
      ),
    );
    gh.factory<_i919.ProfileRepository>(
      () => _i695.ProfileRepositoryImpl(gh<_i214.ProfileRemoteDataSource>()),
    );
    gh.lazySingleton<_i478.GetExamsOnSubjectRepo>(
      () => _i576.GetExamsOnSubjectRepoImpl(
        gh<_i88.GetExamsOnSubjectRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i711.VerifyResetCodeUseCase>(
      () => _i711.VerifyResetCodeUseCase(gh<_i519.AuthRepo>()),
    );
    gh.factory<_i307.LoginUescase>(
      () => _i307.LoginUescase(gh<_i519.AuthRepo>()),
    );
    gh.factory<_i971.GetExamQuestionsUsecase>(
      () => _i971.GetExamQuestionsUsecase(gh<_i366.GetExamQuestionsRepo>()),
    );
    gh.lazySingleton<_i187.ResetPasswordUseCase>(
      () => _i187.ResetPasswordUseCase(gh<_i519.AuthRepo>()),
    );
    gh.lazySingleton<_i152.SendResetCodeUseCase>(
      () => _i152.SendResetCodeUseCase(sendRestCodeRepo: gh<_i519.AuthRepo>()),
    );
    gh.factory<_i754.SignupUseCase>(
      () => _i754.SignupUseCase(repository: gh<_i519.AuthRepo>()),
    );
    gh.factory<_i655.IsLoggedInUsecase>(
      () => _i655.IsLoggedInUsecase(loginRepo: gh<_i519.AuthRepo>()),
    );
    gh.lazySingleton<_i109.GetAllSubjectsUseCase>(
      () => _i109.GetAllSubjectsUseCase(gh<_i234.GetAllSubjectsRepo>()),
    );
    gh.lazySingleton<_i376.GetallSubjectsBloc>(
      () => _i376.GetallSubjectsBloc(gh<_i109.GetAllSubjectsUseCase>()),
    );
    gh.factory<_i533.ChangePasswordUseCase>(
      () => _i533.ChangePasswordUseCase(gh<_i919.ProfileRepository>()),
    );
    gh.factory<_i221.EditProfileUseCase>(
      () => _i221.EditProfileUseCase(gh<_i919.ProfileRepository>()),
    );
    gh.factory<_i248.GetProfileUseCase>(
      () => _i248.GetProfileUseCase(gh<_i919.ProfileRepository>()),
    );
    gh.factory<_i563.ExamPageBloc>(
      () => _i563.ExamPageBloc(gh<_i971.GetExamQuestionsUsecase>()),
    );
    gh.factory<_i990.ProfileCubit>(
      () => _i990.ProfileCubit(
        gh<_i248.GetProfileUseCase>(),
        gh<_i221.EditProfileUseCase>(),
        gh<_i533.ChangePasswordUseCase>(),
      ),
    );
    gh.lazySingleton<_i324.ForgetPasswordBloc>(
      () => _i324.ForgetPasswordBloc(
        gh<_i152.SendResetCodeUseCase>(),
        gh<_i711.VerifyResetCodeUseCase>(),
        gh<_i187.ResetPasswordUseCase>(),
      ),
    );
    gh.lazySingleton<_i517.GetExamsOnSubjectsUseCase>(
      () => _i517.GetExamsOnSubjectsUseCase(
        getExamsOnSubjectRepo: gh<_i478.GetExamsOnSubjectRepo>(),
      ),
    );
    gh.factory<_i985.AuthViewModel>(
      () => _i985.AuthViewModel(
        gh<_i307.LoginUescase>(),
        gh<_i655.IsLoggedInUsecase>(),
      ),
    );
    gh.factory<_i718.SignupCubit>(
      () => _i718.SignupCubit(gh<_i754.SignupUseCase>()),
    );
    gh.lazySingleton<_i1044.SubjectDetailsBloc>(
      () => _i1044.SubjectDetailsBloc(gh<_i517.GetExamsOnSubjectsUseCase>()),
    );
    return this;
  }
}

class _$DbModule extends _i982.DbModule {}

class _$RegisterModule extends _i176.RegisterModule {}

class _$SecureStorageModule extends _i319.SecureStorageModule {}
