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
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:thamara/core/api/api_consumer.dart' as _i920;
import 'package:thamara/core/api/dio_consumer.dart' as _i40;
import 'package:thamara/core/api/dio_log_interceptor.dart' as _i707;
import 'package:thamara/core/api/network_info.dart' as _i819;
import 'package:thamara/core/dependency_injection/di_api_consumer_polymorphism.dart'
    as _i248;
import 'package:thamara/core/dependency_injection/di_module.dart' as _i351;
import 'package:thamara/core/locals/secure_storage.dart' as _i173;
import 'package:thamara/core/locals/shared_preferences.dart' as _i757;
import 'package:thamara/core/services/firebase_service.dart' as _i879;
import 'package:thamara/core/services/Location_Service.dart' as _i887;
import 'package:thamara/features/auth/login/data/data_source/local/login_local_data_source.dart'
    as _i734;
import 'package:thamara/features/auth/login/data/data_source/local/login_local_data_source_implementation.dart'
    as _i647;
import 'package:thamara/features/auth/login/data/data_source/remote/login_data_source.dart'
    as _i235;
import 'package:thamara/features/auth/login/data/data_source/remote/login_data_source_implementation.dart'
    as _i547;
import 'package:thamara/features/auth/login/data/repos/login_repo.dart'
    as _i198;
import 'package:thamara/features/auth/login/data/repos/login_repo_implementation.dart'
    as _i461;
import 'package:thamara/features/auth/login/presentation/cubit/login_cubit.dart'
    as _i201;
import 'package:thamara/features/auth/otp/data/data_sources/local/otp_local_data_source.dart'
    as _i640;
import 'package:thamara/features/auth/otp/data/data_sources/local/otp_local_data_source_impl.dart'
    as _i64;
import 'package:thamara/features/auth/otp/data/data_sources/remote/otp_remote_data_source.dart'
    as _i1055;
import 'package:thamara/features/auth/otp/data/data_sources/remote/otp_remote_data_source_impl.dart'
    as _i460;
import 'package:thamara/features/auth/otp/data/repos/otp_repository.dart'
    as _i318;
import 'package:thamara/features/auth/otp/data/repos/otp_repository_impl.dart'
    as _i289;
import 'package:thamara/features/auth/otp/presentation/cubits/otp_cubit.dart'
    as _i310;
import 'package:thamara/features/auth/reset_password/data/data_sources/remote/password_settings_remote_data_source.dart'
    as _i69;
import 'package:thamara/features/auth/reset_password/data/data_sources/remote/password_settings_remote_data_source_impl.dart'
    as _i254;
import 'package:thamara/features/auth/reset_password/data/repos/password_settings_repository.dart'
    as _i843;
import 'package:thamara/features/auth/reset_password/data/repos/password_settings_repository_impl.dart'
    as _i787;
import 'package:thamara/features/auth/reset_password/presentation/cubits/new_password_cubit/new_password_cubit.dart'
    as _i973;
import 'package:thamara/features/auth/reset_password/presentation/cubits/reset_password_cubit/reset_password_cubit.dart'
    as _i60;
import 'package:thamara/features/auth/sign_up/data/data_source/local/register_local_data_source.dart'
    as _i509;
import 'package:thamara/features/auth/sign_up/data/data_source/local/register_local_data_source_implementation.dart'
    as _i326;
import 'package:thamara/features/auth/sign_up/data/data_source/register_remote_data_source.dart'
    as _i425;
import 'package:thamara/features/auth/sign_up/data/data_source/register_remote_data_source_implementation.dart'
    as _i666;
import 'package:thamara/features/auth/sign_up/data/repos/register_repo.dart'
    as _i69;
import 'package:thamara/features/auth/sign_up/data/repos/register_repo_implementation.dart'
    as _i648;
import 'package:thamara/features/auth/sign_up/presentation/cubit/register_cubit.dart'
    as _i692;
import 'package:thamara/features/home/data/data_source/remote_data_source/ai_feature_data_source.dart'
    as _i618;
import 'package:thamara/features/home/data/data_source/remote_data_source/ai_feature_data_source_impl.dart'
    as _i737;
import 'package:thamara/features/home/data/repos/ai_feature_repo.dart' as _i779;
import 'package:thamara/features/home/data/repos/ai_feature_repo_impl.dart'
    as _i349;
import 'package:thamara/features/home/presentation/cubit/ai_feature_cubit.dart'
    as _i387;
import 'package:thamara/features/notifications/data/data_source/notifications_remote_data_source.dart'
    as _i990;
import 'package:thamara/features/notifications/data/data_source/notifications_remote_data_source_impl.dart'
    as _i897;
import 'package:thamara/features/notifications/data/repository/notifications_repository.dart'
    as _i307;
import 'package:thamara/features/notifications/data/repository/notifications_repository_impl.dart'
    as _i858;
import 'package:thamara/features/notifications/presentation/cubit/notifications_cubit.dart'
    as _i294;
import 'package:thamara/features/plant_details/data/data_source/remote_data_source/plant_details_data_source.dart'
    as _i762;
import 'package:thamara/features/plant_details/data/data_source/remote_data_source/plant_details_data_source_impl.dart'
    as _i158;
import 'package:thamara/features/plant_details/data/repos/plant_details_repo.dart'
    as _i250;
import 'package:thamara/features/plant_details/data/repos/plant_details_repo_impl.dart'
    as _i415;
import 'package:thamara/features/plant_details/presentation/cubit/plant_details_cubit.dart'
    as _i682;
import 'package:thamara/features/settings/data/data_source/remote_data_source/profile_info_data_source.dart'
    as _i385;
import 'package:thamara/features/settings/data/data_source/remote_data_source/profile_info_data_source_impl.dart'
    as _i753;
import 'package:thamara/features/settings/data/repos/profile_info_repo.dart'
    as _i942;
import 'package:thamara/features/settings/data/repos/profile_info_repo_impl.dart'
    as _i852;
import 'package:thamara/features/settings/presentation/cubit/profile_cubit.dart'
    as _i642;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectionModule = _$InjectionModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.factory<_i161.InternetConnection>(
      () => injectionModule.internetConnection,
    );
    gh.factory<_i361.Dio>(() => injectionModule.dioClient);
    gh.factory<_i887.LocationService>(() => _i887.LocationService());
    gh.factory<_i879.FirebaseService>(() => _i879.FirebaseService());
    gh.lazySingleton<_i707.DioLogInterceptor>(() => _i707.DioLogInterceptor());
    gh.lazySingleton<_i819.NetworkInfo>(() => _i819.NetworkInfo());
    gh.lazySingleton<_i248.ApiConsumerPolymorphism>(
      () => _i248.ApiConsumerPolymorphism(),
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => injectionModule.secureStorage,
    );
    gh.lazySingleton<_i361.Dio>(
      () => injectionModule.aiDio(),
      instanceName: 'aiDio',
    );
    gh.lazySingleton<_i173.CachedSecure>(
      () => _i173.CachedSecure(storage: gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i757.SharedPrefServices>(
      () => _i757.SharedPrefServices(
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i640.OTPLocalDataSource>(
      () => _i64.OTPLocalDataSourceImpl(
        appPref: gh<_i757.SharedPrefServices>(),
        secure: gh<_i173.CachedSecure>(),
      ),
    );
    gh.factory<_i734.LoginLocalDataSource>(
      () => _i647.LoginLocalDataSourceImpl(
        appPref: gh<_i757.SharedPrefServices>(),
        secure: gh<_i173.CachedSecure>(),
      ),
    );
    gh.factory<_i618.AiFeatureDataSource>(
      () => _i737.AiFeatureDataSourceImpl(
        gh<_i361.Dio>(instanceName: 'aiDio'),
        cachedSecure: gh<_i173.CachedSecure>(),
      ),
    );
    gh.lazySingleton<_i920.ApiConsumer>(
      () => _i40.DioApiConsumer(
        networkInfo: gh<_i819.NetworkInfo>(),
        dioClient: gh<_i361.Dio>(),
        cachedSecure: gh<_i173.CachedSecure>(),
        appPref: gh<_i757.SharedPrefServices>(),
      ),
    );
    gh.factory<_i509.RegisterLocalDataSource>(
      () => _i326.RegisterLocalDataSourceImpl(
        appPref: gh<_i757.SharedPrefServices>(),
        secure: gh<_i173.CachedSecure>(),
      ),
    );
    gh.factory<_i779.AiFeatureRepo>(
      () => _i349.AiFeatureRepoImpl(
        remoteDataSource: gh<_i618.AiFeatureDataSource>(),
      ),
    );
    gh.factory<_i387.AiFeatureCubit>(
      () => _i387.AiFeatureCubit(gh<_i779.AiFeatureRepo>()),
    );
    gh.factory<_i69.PasswordSettingsRemoteDataSource>(
      () => _i254.PasswordSettingsRemoteDataSourceImpl(
        apiConsumer: gh<_i920.ApiConsumer>(),
      ),
    );
    gh.factory<_i990.NotificationsRemoteDataSource>(
      () => _i897.NotificationsRemoteDataSourceImpl(
        apiConsumer: gh<_i920.ApiConsumer>(),
      ),
    );
    gh.factory<_i425.RegisterRemoteDataSource>(
      () => _i666.RegisterRemoteDataSourceImplementation(
        apiConsumer: gh<_i920.ApiConsumer>(),
      ),
    );
    gh.factory<_i1055.OTPRemoteDataSource>(
      () => _i460.OTPRemoteDataSourceImpl(apiConsumer: gh<_i920.ApiConsumer>()),
    );
    gh.factory<_i843.PasswordSettingsRepository>(
      () => _i787.PasswordSettingsRepositoryImpl(
        passwordSettingsRemoteDataSource:
            gh<_i69.PasswordSettingsRemoteDataSource>(),
      ),
    );
    gh.factory<_i385.ProfileInfoDataSource>(
      () =>
          _i753.ProfileInfoDataSourceImpl(apiConsumer: gh<_i920.ApiConsumer>()),
    );
    gh.factory<_i762.PlantDetailsDataSource>(
      () => _i158.PlantDetailsDataSourceImpl(
        apiConsumer: gh<_i920.ApiConsumer>(),
      ),
    );
    gh.factory<_i318.OTPRepository>(
      () => _i289.OTPRepositoryImpl(
        authRemoteDataSource: gh<_i1055.OTPRemoteDataSource>(),
        authLocalDataSource: gh<_i640.OTPLocalDataSource>(),
      ),
    );
    gh.factory<_i235.LoginDataSource>(
      () => _i547.LoginDataSourceImplementation(
        apiConsumer: gh<_i920.ApiConsumer>(),
      ),
    );
    gh.factory<_i973.NewPasswordCubit>(
      () => _i973.NewPasswordCubit(
        passwordSettingsRepo: gh<_i843.PasswordSettingsRepository>(),
      ),
    );
    gh.factory<_i307.NotificationsRepository>(
      () => _i858.NotificationsRepositoryImpl(
        notificationsRemoteDataSource:
            gh<_i990.NotificationsRemoteDataSource>(),
      ),
    );
    gh.factory<_i250.PlantDetailsRepo>(
      () => _i415.PlantDetailsRepoImpl(
        plantDetailsDataSource: gh<_i762.PlantDetailsDataSource>(),
      ),
    );
    gh.factory<_i294.NotificationsCubit>(
      () => _i294.NotificationsCubit(
        repository: gh<_i307.NotificationsRepository>(),
      ),
    );
    gh.factory<_i942.ProfileInfoRepo>(
      () => _i852.ProfileInfoRepoImpl(
        profileInfoDataSource: gh<_i385.ProfileInfoDataSource>(),
      ),
    );
    gh.factory<_i198.LoginRepo>(
      () => _i461.LoginRepoImplementation(
        loginRemoteDataSource: gh<_i235.LoginDataSource>(),
        loginLocalDataSource: gh<_i734.LoginLocalDataSource>(),
      ),
    );
    gh.factory<_i310.OTPCubit>(
      () => _i310.OTPCubit(otpRepository: gh<_i318.OTPRepository>()),
    );
    gh.factory<_i69.RegisterRepository>(
      () => _i648.RegisterRepoImplementation(
        registerRemoteDataSource: gh<_i425.RegisterRemoteDataSource>(),
        registerLocalDataSource: gh<_i509.RegisterLocalDataSource>(),
      ),
    );
    gh.factory<_i60.ResetPasswordCubit>(
      () => _i60.ResetPasswordCubit(
        passwordSettingsRepository: gh<_i843.PasswordSettingsRepository>(),
      ),
    );
    gh.factory<_i682.PlantDetailsCubit>(
      () => _i682.PlantDetailsCubit(gh<_i250.PlantDetailsRepo>()),
    );
    gh.factory<_i692.RegisterCubit>(
      () => _i692.RegisterCubit(
        registerRepository: gh<_i69.RegisterRepository>(),
      ),
    );
    gh.factory<_i642.ProfileCubit>(
      () => _i642.ProfileCubit(gh<_i942.ProfileInfoRepo>()),
    );
    gh.factory<_i201.LoginCubit>(
      () => _i201.LoginCubit(
        loginRepository: gh<_i198.LoginRepo>(),
        sharedPrefServices: gh<_i757.SharedPrefServices>(),
        firebaseService: gh<_i879.FirebaseService>(),
        locationService: gh<_i887.LocationService>(),
      ),
    );
    return this;
  }
}

class _$InjectionModule extends _i351.InjectionModule {}
