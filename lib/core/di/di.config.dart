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

import '../../features/Home/data/repository/home_repository_imp.dart' as _i394;
import '../../features/Home/data/source/home_api_service.dart' as _i557;
import '../../features/Home/data/source/home_remote_data_source.dart' as _i870;
import '../../features/Home/data/source/home_remote_data_source_imp.dart'
    as _i862;
import '../../features/Home/domain/repository/home_repository.dart' as _i722;
import '../../features/Home/domain/usecase/home_usecase.dart' as _i751;
import '../../features/Home/presentation/bloc/home_bloc.dart' as _i167;
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
    gh.factory<_i557.HomeApiService>(
        () => _i557.HomeApiService(gh<_i361.Dio>()));
    gh.factory<_i870.HomeRemoteDataSource>(
        () => _i862.HomeRemoteDataSourceImp(gh<_i557.HomeApiService>()));
    gh.factory<_i722.HomeRepository>(
        () => _i394.HomeRepositoryImpl(gh<_i870.HomeRemoteDataSource>()));
    gh.factory<_i751.GetHomeDataUseCase>(
        () => _i751.GetHomeDataUseCase(gh<_i722.HomeRepository>()));
    gh.factory<_i167.HomeBloc>(
        () => _i167.HomeBloc(gh<_i751.GetHomeDataUseCase>()));
    return this;
  }
}

class _$DioModule extends _i288.DioModule {}
