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

import '../../features/home/api/client/home_api_service.dart' as _i220;
import '../../features/home/api/source/home_remote_data_source_imp.dart'
    as _i265;
import '../../features/home/data/repository/home_repository_imp.dart' as _i342;
import '../../features/home/data/source/home_remote_data_source.dart' as _i557;
import '../../features/home/domain/repository/home_repository.dart' as _i541;
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
    gh.factory<_i541.HomeRepository>(() => _i342.HomeRepositoryImp());
    gh.factory<_i557.HomeRemoteDataSource>(
        () => _i265.HomeRemoteDataSourceImp());
    gh.factory<_i220.HomeApiService>(
        () => _i220.HomeApiService(gh<_i361.Dio>()));
    return this;
  }
}

class _$DioModule extends _i288.DioModule {}
