// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../features/auth/api/client/auth_api_service.dart' as _i522;
import '../../features/auth/api/source/auth_remote_data_souce_imp.dart'
    as _i669;
import '../../features/auth/data/repository/auth_repository_imp.dart' as _i794;
import '../../features/auth/data/source/auth_remote_data_source.dart' as _i777;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import 'modules/dio_modules.dart' as _i288;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.provideDio());
    gh.lazySingleton<_i528.PrettyDioLogger>(
        () => dioModule.prettyDioLoggerProvider());
    gh.factory<_i961.AuthRepository>(() => _i794.AuthRepositoryImp());
    gh.factory<_i777.AuthRemoteDataSource>(
        () => _i669.AuthRemoteDataSouceImp());
    gh.factory<_i522.AuthApiService>(
        () => _i522.AuthApiService(gh<_i361.Dio>()));
    return this;
  }
}

class _$DioModule extends _i288.DioModule {}
