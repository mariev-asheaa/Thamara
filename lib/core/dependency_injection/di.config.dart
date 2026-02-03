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
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:thamara/core/api/api_consumer.dart' as _i920;
import 'package:thamara/core/dependency_injection/di_module.dart' as _i351;
import 'package:thamara/core/locals/secure_storage.dart' as _i173;
import 'package:thamara/core/locals/shared_preferences.dart' as _i757;
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
    gh.lazySingleton<_i361.Dio>(() => injectionModule.dioClient);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => injectionModule.secureStorage,
    );
    gh.factory<_i425.RegisterRemoteDataSource>(
      () => _i666.RegisterRemoteDataSourceImplementation(
        apiConsumer: gh<_i920.ApiConsumer>(),
      ),
    );
    gh.factory<_i235.LoginDataSource>(
      () => _i547.LoginDataSourceImplementation(
        apiConsumer: gh<_i920.ApiConsumer>(),
      ),
    );
    gh.factory<_i734.LoginLocalDataSource>(
      () => _i647.LoginLocalDataSourceImpl(
        appPref: gh<_i757.SharedPrefServices>(),
        secure: gh<_i173.CachedSecure>(),
      ),
    );
    gh.factory<_i198.LoginRepo>(
      () => _i461.LoginRepoImplementation(
        loginRemoteDataSource: gh<_i235.LoginDataSource>(),
        loginLocalDataSource: gh<_i734.LoginLocalDataSource>(),
      ),
    );
    gh.factory<_i201.LoginCubit>(
      () => _i201.LoginCubit(
        gh<_i198.LoginRepo>(),
        gh<_i757.SharedPrefServices>(),
      ),
    );
    gh.factory<_i69.RegisterRepository>(
      () => _i648.RegisterRepoImplementation(
        registerRemoteDataSource: gh<_i425.RegisterRemoteDataSource>(),
      ),
    );
    gh.factory<_i692.RegisterCubit>(
      () => _i692.RegisterCubit(
        registerRepository: gh<_i69.RegisterRepository>(),
      ),
    );
    return this;
  }
}

class _$InjectionModule extends _i351.InjectionModule {}
